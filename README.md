# delimcc.st
A port of http://www.squeaksource.com/Control for Pharo Smalltalk.

Load with:
```smalltalk
Metacello new
    baseline: 'Delimcc';
    repository: 'github://massimo-nocentini/delimcc.st:master';
    load
```

## Description
This project demonstrates an implementation of the shift/reset control operators used for constructing and evaluating partial continuations. It owes a great deal to the extensive literature on the subject, but in particular to [Final Shift for Call/cc: Direct Implementation of Shift and Reset](https://www.researchgate.net/publication/2546665_Final_Shift_for_Callcc_Direct_Implementation_of_Shift_and_Reset), by Martin Gasbichler and Michael Sperber, and to Seaside's Flow package, from which I "borrowed" serialisation/deserialisation, and learned how to stitch a partial continuation onto the current stack.

## Semantics
The examples below are executed by `DelimccReadmeTest`: each block answers the value in its last comment. `scripts/readme.st` checks that they are the ones of the test.

### Prompts
A `DelimccPrompt` is a prompt of the multi-prompt delimited control of Dybvig, Peyton Jones and Sabry, as in Kiselyov's delimcc:
- `p delimit: aBlock` (pushPrompt) evaluates `aBlock` delimited by `p`, and `p isDelimiting` tells whether a delimiter of `p` is on the stack;
- `p withSubCont: [ :k | ... ]` (withSubCont) cuts the stack down to the nearest delimiter of `p`, which it removes, reifies the contexts above it as `k`, a `PartialContinuation`, and evaluates the block in their place;
- `k pushSubCont: aBlock` runs the contexts of `k` on top of the stack and `aBlock` on top of them, and `k value: x` is `k pushSubCont: [ x ]`;
- `p shift:`, `p shift0:`, `p control:`, `p control0:` and `p abort: x` are derived from them, with the meaning that the literature gives them: `p shift:` is the shift of Danvy and Filinski.

Prompts are independent: a capture to `p` goes through the delimiters of `q`, which `k` then holds.

```smalltalk
| p q |
p := DelimccPrompt named: 'p'.
q := DelimccPrompt named: 'q'.
{ 1 + (p delimit: [ 10 + (p shift: [ :k | k value: (k value: 100) ]) ]).
  p delimit: [ 1 + (q delimit: [ 10 + (p shift: [ :k | k value: (k value: 100) ]) ]) ].
  1 + (p delimit: [ 10 + (p abort: 5) ]) }
"--> #(121 122 6)"
```

`[ ... ] reset` delimits with the prompt `DelimccPrompt reset`, and `[ :k | ... ] shift` captures to it.

### shift is shift0
`shift` is shift0: the continuation `k` it captures contains the delimiting `reset`, so every invocation of `k` is delimited again, but the body of the `shift` runs without it. Shan's probe tells them apart: `shift` answers `''` where Danvy and Filinski's shift answers `'a'`. Hansei relies on this. The names on `DelimccPrompt` are those of the literature, so `p shift0:` is the legacy `shift`.

```smalltalk
| p |
p := DelimccPrompt named: 'p'.
{ [ 'a' , [ [ :f | [ :g | '' ] shift ] shift ] reset ] reset.
  p delimit: [ 'a' , (p delimit: [ p shift0: [ :f | p shift0: [ :g | '' ] ] ]) ].
  p delimit: [ 'a' , (p delimit: [ p shift: [ :f | p shift: [ :g | '' ] ] ]) ].
  p delimit: [ 'a' , (p delimit: [ p control: [ :f | p control: [ :g | '' ] ] ]) ] }
"--> #('' '' 'a' 'a')"
```

`reset` marks the call stack with a `DelimccPrompt>>#delimit:` context that `shift` finds by walking the senders, and `DelimitedDynamicVariable>>#dlet:in:` does the same with a `DelimitedDynamicVariableRef`: no exception is signalled, so handlers such as `on: Exception do:` inside a `reset` or a `dlet:in:` do not interfere. The marks are found by receiver and selector, so recompiling `delimit:` or `during:` does not hide them.

These marks replaced the exception-based machinery, which is gone: `DelimitedControlException`, `BlockClosure>>#resetContext:` and `PartialContinuation>>#copy:bottomContextDo:` were removed, and `DelimitedDynamicVariableRef` is no longer a `Notification`, so it has no `dynVar:`, `hasValue` or `handles:`, and `[ p dref ] on: p do: [ :e | ... ]` no longer intercepts the lookup of `p`.

### Invocations
A capture cuts the contexts of `k` off the stack, so `k` does not hold the stack below its delimiter. The first invocation of `k` runs these contexts themselves: it is exactly the computation that the capture interrupted. Every later invocation runs fresh copies, made from a template that the first one keeps (`DelimccSliceCopier`), or, for a `k` deeper than 16 contexts, that the second one makes from a plain copy that the first one keeps (`DelimccSliceSnapshot`), in which the closures, the exceptions and the contexts of `k` refer to each other's copies. So a `^` in a block of `k` returns from the copy of its home, and an exception handler of `k` handles, resumes, retries and returns in its copy, in every invocation.

```smalltalk
{ [ #( 1 2 3 ) detect: [ :x | [ :k | (k value: true) + (k value: false) ] shift ] ifNone: [ 0 ] ] reset.
  [ ([ 1 / 0 ] on: ZeroDivide do: [ :e | [ :k | (k value: 1) + (k value: 2) ] shift ]) * 10 ] reset }
"--> #(6 30)"
```

### Temporaries and the heap
The temporaries of the contexts of `k` are copied with them, as they were when `k` was first invoked, whether the compiler kept them in the contexts or in temp vectors: each invocation has its own. Heap objects are shared by all the invocations, as the heap is in Kiselyov's delimcc: instance variables, collections, a dynamic variable, and the temporaries of the contexts below the delimiter. A heap object is the way to share a variable between invocations.

```smalltalk
| cell |
cell := Array with: 0.
{ [ | x | x := 0. [ :k | (k value: 1) + (k value: 1) ] shift. [ x := x + 1 ] value. x ] reset.
  [ [ :k | (k value: 1) + (k value: 1) ] shift. cell at: 1 put: (cell at: 1) + 1 ] reset }
"--> #(2 3)"
```

### ensure: and ifCurtailed:
They follow delimcc, not the dynamic-wind of Racket: a capture or an abort runs no unwind block, and neither does a `k` that is never invoked; each invocation that completes runs the `ensure:` blocks of its own contexts once, and an invocation that is unwound runs its `ifCurtailed:` blocks. `k unwind` runs the unwind blocks of a `k` that has never been invoked and never will be, such as an abandoned generator, and does nothing once `k` has been invoked. It takes the place of the first invocation, so `k` stays invocable: a later invocation runs a fresh copy, as any invocation after the first does, on the state that the unwind blocks have left, such as a closed stream.

```smalltalk
| log k |
log := OrderedCollection new.
k := [ [ [ :kk | kk ] shift ] ensure: [ log add: #ensure ] ] reset.
log add: #captured.
k value: 1.
k value: 2.
k unwind.
k := [ [ #( 1 2 3 ) do: [ :x | [ :kk | kk ] shift ] ] ensure: [ log add: #closed ] ] reset.
k unwind.
log asArray
"--> #(#captured #ensure #ensure #closed)"
```

### callcc
`[ :k | ... ] callcc` runs the block on the original stack, so the code around it keeps its non-local returns and its handlers. `k` is the rest of the computation up to the nearest `reset`: invoking it once `callcc` has answered replaces that `reset` with a copy of the rest. Unlike the continuations of `shift`, these copies share the temp vectors of the original contexts, as Scheme shares its variables, so the classic loop sees `kc` in each of them; a temporary that no block captures, such as `m`, is still copied. The copies hand on an exception whose handler called `callcc` as it was then, so `e pass`, `e signal` or `e outer` after the `callcc` reaches the copy of the same outer handler in each re-entry, even once the original has passed it.

```smalltalk
[ | m kc | m := [ :k | kc := k. 0 ] callcc. m < 3 ifTrue: [ kc value: m + 1 ]. m ] reset
"--> 3"
```

### Limits
- A closure that a heap object holds, such as a block in an instance variable, is not re-pointed: its `^` works in the first invocation only, and raises `BlockCannotReturn` in the later ones.
- A temporary of `k` that one invocation assigns is not seen by the later ones, since each starts from the state of the first; share it through a heap object.
- A temporary of a scope that has ended, such as a loop body of an earlier iteration or a block that has returned, is in no context of `k` any more: a closure of that scope that `k` runs shares it with every invocation, as a heap object.
- The debugger steps into and over captures and invocations, and the copies leave out the contexts that it inserts to step over a send, as the first invocation does once that step cannot end, when k has escaped the capture.
- Continuations are not serialisable: a materialised `k` holds a copy of its prompt, which the delimiters of the original prompt do not delimit.
- Against the plain copy of each invocation that preceded the template (`scripts/bench.st`, on P12 and P15): a `k` of 16 contexts or fewer, fixed at its first invocation, costs up to about 1.9 times when invoked once or twice; a deeper `k` invoked once, as by a generator, costs 1.2 to 2.2 times, since its first invocation only copies it, one invoked exactly twice up to about 3.2 times, and one invoked many times about half.

## Attribution
The work is by 	Frank Shearar and	Levente Uzonyi, I just loaded in Pharo and did a little fix to make tests green.

