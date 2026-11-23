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
- A `Continuation`, Pharo's undelimited continuation, captured inside a delimiter before a capture holds the bottom part of the contexts of that `k`, and invoking it resumes them. If that happens before the first invocation of `k`, `k` can no longer run them: its first invocation, and every later one, signals `DelimccResumedSliceError`, both once the resumed computation has left them and while it still runs them. A `k` invoked before the `Continuation` has kept its template, so the `Continuation` changes nothing for it. The check does not see a resumed computation that has cut the same contexts off the stack again with a new capture, which `k` would then run in place of its own.
- Continuations are not serialisable: a materialised `k` holds a copy of its prompt, which the delimiters of the original prompt do not delimit.
- Against the plain copy of each invocation that preceded the template (`scripts/bench.st`, on P12 and P15): a `k` of 16 contexts or fewer, fixed at its first invocation, costs up to about 1.9 times when invoked once or twice; a deeper `k` invoked once, as by a generator, costs 1.2 to 2.2 times, since its first invocation only copies it, one invoked exactly twice up to about 3.2 times, and one invoked many times about half.

## Patches to Pharo's Continuation
`Delimcc-Continuation` fixes Pharo's own undelimited `Continuation` (package `System-Utilities`) with extension methods, and `Delimcc-Continuation-Tests` fixes its tests (package `System-Utilities-Tests`) the same way. Delimcc itself does not use `Continuation`. The default group loads both packages; the `Continuation` group loads only them:
```smalltalk
Metacello new
    baseline: 'Delimcc';
    repository: 'github://massimo-nocentini/delimcc.st:master';
    load: 'Continuation'
```

Methods that `Delimcc-Continuation` overrides or adds:
- `Continuation>>#value:` checks before it changes anything. A continuation that was never captured (`Continuation new value: 1`), or that holds no frame (`Continuation fromContext: nil`), signals an `Error`, and so does a continuation whose stack another live process is running. Stock `value:` cut the stack first, so no handler could catch the first error, and the second case made the invoking process run the frames of the other one, which the VM then dropped as a zombie. If both checks pass, `value:` unwinds only the frames it abandons, as `Exception>>#return:` does: every frame of the current stack that the captured stack does not hold, above the longest bottom part that the two stacks have in common. That includes a frame below one that both stacks share, when a sender link was rewired after the capture, as `Generator>>#next` does each time. Their `ensure:` and `ifCurtailed:` blocks run once, from the top down, and the frames are terminated. Stock `value:` ran no unwind block, so an escape out of `Semaphore>>#critical:` or `Mutex>>#critical:` left the lock taken, and the abandoned frames still looked alive. Stepping over `k value:` in the debugger no longer kills the debugger's process (Pharo issue #5878): the step ends inside `value:`, when the debugger's own ensure frame is unwound.
- `Continuation>>#valueWithoutUnwinding:` (new) invokes the continuation with the same checks as `value:`, but it only terminates the frames it abandons, without running their `ensure:` and `ifCurtailed:` blocks, as stock `value:` did. It is the jump for generators and coroutines, whose frames are re-entered later through another continuation (see the change from stock below).
- `Continuation>>#invokeWith:unwinding:` (new, private) does the work of both. `value:` and `valueWithoutUnwinding:` answer what it answers.
- `Continuation>>#capturedContexts`, `Continuation>>#anotherLiveProcessRunning:` and `Continuation>>#scanForAnotherProcessRunning:` (new, private). These are the two checks above. Nothing is recorded when the continuation is captured. `value:` scans the live processes, looking for one whose stack holds any of the captured frames that the current stack does not hold above the bottom part that the two stacks share: all of them when the two stacks share no frame, and otherwise those that have not returned. A `PartialContinuation` of Delimcc can take some captured frames to another process, so the invoker can share frames with the captured stack while the capturer, still alive, holds the others, or the capturer can share the bottom of it while another process runs the frames above. An escape has no such frame, and the frames that a re-entry restores have usually returned, so neither of them scans. Comparing the bottom contexts would miss a capturer that another process is terminating, because `Process>>#terminate` inserts contexts below its bottom one while its unwind blocks run. `Process allSubInstances` also answers processes that nothing references any more and that can never run again, such as a capturer that suspended itself and was dropped, so when a first scan finds a process, the garbage collector runs and a second scan decides. Only an invocation on its way to the Error pays for that collection. A process that the captured frames themselves reference stays live: k could still reach it and resume it. The scan only answers the process: both Errors are signalled with `^` from the method that `value:` returns from, so if a handler resumes one of them, as the debugger's Proceed does, `value:` answers the resumed value and leaves both stacks alone.
- `Continuation>>#cull:`, `#cull:cull:`, `#cull:cull:cull:`, `#cull:cull:cull:cull:` and `#valueWithPossibleArgs:` (new). They invoke the continuation with the first argument, or with nil when there is none, as a one-argument block does. So `k` can be an exception handler (`[ 1 / 0 ] on: ZeroDivide do: k`), the argument of `ifNotNil:`, and any block of the `try:` family.
- `Continuation>>#valueWithArguments:` resumes with nil when the array is empty, as `value` does.
- `Continuation class>>#try:otherwise:` culls its try block. `try:or:otherwise:` and `try:or:or:otherwise:` pass their try block to it, so in all three the try block can now take no argument. Stock `try:otherwise:` sent it `value:`, so all three raised `ArgumentsCountMismatch` for a try block such as `[ 42 ]`.
- `Continuation>>#initializeFromContext:` saves each frame followed by a snapshot of it, one `#shallowCopy` of the context, instead of one `#instVarAt:` or `#at:` send per slot into a `WriteStream`. Capturing is 2.4 times faster (1000 frames: 882 -> 363 us on Pharo 12, 910 -> 378 us on Pharo 15). The cost is memory: a snapshot is a full-size `Context` (22 or 62 slots, whatever its stack depth), where the stock layout stores 7 slots plus the stack of each frame, so a continuation that is kept alive takes about 2.3 times the heap of the stock one (1000 frames: 236 KB instead of 102 KB on Pharo 12; 1.5 times for frames with 20 temporaries), and a full GC with many of them alive takes about a quarter longer (5000 continuations 10 frames deep: 132 instead of 104 ms on Pharo 12, 156 instead of 120 ms on Pharo 15). Primitive 168 needs a snapshot of the same size as the context, and an exact-size copy would need the per-slot stores of the stock code, so there is no cheaper layout without a VM change. A first walk counts the frames for the `Array`, and the second one that saves them stops at that count: when the captured stack belongs to another process that preempts the capture and returns from some of its frames, or rewires a sender, in between, the values hold exactly the contexts that the second walk reaches, as with the single walk of the stock code, and no trailing nil pairs.
- `Continuation>>#restoreValues`, with `#restore:from:` and `#copyInto:from:` (new, private), stores the pc of each context, which moves a frame that is still on a stack page into its context, and then copies the snapshot into the context with one primitive (the one of `Object>>#copyFrom:`). The snapshots are never executed, so they stay as captured across re-entries. Restoring 1000 frames inside an escape through `value:` takes about 140 us instead of 355 us on Pharo 15 (140 to 180 us instead of 335 us on Pharo 12), 2 to 2.5 times faster.
- `Continuation>>#hasSnapshots` and `#restoreSlotValues` (new, private) tell apart and restore, as the stock code did, a continuation captured before `Delimcc-Continuation` was loaded, which keeps the stock layout of its values. `#capturedContexts` reads both layouts.
- `Continuation>>#invokeWith:unwinding:` compares the two stacks from their bottoms before it looks frames up, so it only builds a set of the captured frames above the part they share, which an escape does not have. With the faster capture and restore, an escape through `value:` 1000 frames deep takes 603 us on Pharo 12 and 622 us on Pharo 15, against 1218 and 1245 us for the stock escape (which ran no unwind block) and 1462 and 1512 us before these changes. At depths from 10 to 5000, a double re-entry is 2.0 to 2.2 times faster than stock and 2.4 to 3.1 times faster than before, and an escape through `try:otherwise:` 2.2 to 2.7 and 2.4 to 5.1 times.

Methods that `Delimcc-Continuation-Tests` overrides or adds:
- `TwoInARowStar>>#tree:` and `#T:` end the walk with the walker itself, not with nil, and `tree:` no longer requires the first atom to be a Symbol. So `(1 1)` and `(nil nil)` have two in a row.
- `ContinuationTest>>#remove:uptoLast:` and `#intersect:withCollection:` answer a well-formed `LinkedList` built by the new `#linkedListFrom:`. Stock answered `LinkedList with:` a chain of links: a list of nil when nothing was left, otherwise a list whose last link was its first one.
- `ContinuationTest>>#testBlockEscape`, `#testSimplestCallCC`, `#testMethodTemps`, `#testReentrant`, `#testIntersectAll`, `#testIntersectWith`, `#testLeftmost` and `#testTwoInARow` now assert what a `value:` that does not jump gets wrong. `testIntersectWith` now goes through a continuation.
- `DelimccContinuationTest` (new) tests every fix above, the API that `ContinuationTest` never runs, the snapshots and the stock layout, and the limits below.

A change from stock that follows from the unwinding escape, and that `DelimccContinuationTest>>#testYieldingThroughValueRunsTheEnsureBlockAtEachYield` pins: code that jumps out of a frame and back into it, as a generator or a coroutine built from two continuations does at each yield, is no longer balanced with `value:`. An escape now runs the unwind blocks of the frames it abandons, and a re-entry restores them as they were captured, without running again what came before them. So an `ensure:` held across a yield runs its block once per yield and once more at the end (a generator of three values logs `#(#open #close #close #close #close)`), and a `Semaphore>>#critical:` or `Mutex>>#critical:` held across it releases the lock at each yield: another process gets in while the generator is still inside, and a semaphore for mutual exclusion ends with 4 signals. Stock `value:` ran no unwind block, so the same generator logged `#(#open #close)` and kept the lock. Such code should jump with `valueWithoutUnwinding:`, which keeps it balanced (`#testYieldingThroughValueWithoutUnwindingKeepsTheEnsureBlockBalanced`).

Limits that are left as they are, because changing them would change the semantics (`DelimccContinuationTest` pins each one):
- Re-entering a frame restores the `complete` flag of a captured `ensure:` frame, so its block runs once per exit, whether the exit is a normal return or an escape through `value:`. Inside `Semaphore>>#critical:` each re-entry signals the semaphore without waiting on it first, so two processes can end up inside the critical section together.
- Exceptions are not part of the snapshot. A re-entered handler acts on the `handlerContext` that the exception has now: after an `e pass`, its `e return: v` leaves from the outer `on:do:`.
- Re-entry restores the temporaries that live in a frame, but not the ones that the compiler moves into a temp vector because a block writes them, and not instance variables. So a block that never runs can change what a re-entry sees.
- The continuation is undelimited: every capture and every invocation costs time proportional to the whole stack, and `k` keeps alive everything its frames referenced. Once the capturing process has ended, another process may invoke `k`: it abandons its own frames (their unwind blocks run) and then runs the captured frames down to the bottom of the captured process.
- A continuation captured while the debugger steps over `Continuation current` contains the contexts that the debugger inserted, so invoking it later jumps into a debugger frame that has already returned.
- `Continuation>>#terminate:` is no longer used. The class comment of `Continuation` still says nothing about these limits, because a class comment cannot be patched by an extension.

Loading `Delimcc-Continuation` replaces the methods above in place. Their package becomes the extension package, so the Monticello working copies of `System-Utilities` and `System-Utilities-Tests` show as modified. In Iceberg it depends on the Pharo version. On Pharo 12 and 13, the load adds `System-Utilities` to the modified packages of the `pharo` repository (`System-Utilities-Tests` is not one of its packages, so it does not show). On Pharo 14 and 15, Iceberg does not track `System-Utilities` (on Pharo 15 the `pharo` repository lists no packages at all), so nothing shows. Unloading the two packages (Monticello unload, or removing the packages) does not bring the stock methods back. It removes them, so `Continuation` no longer understands `initializeFromContext:`, `restoreValues`, `value:` and `try:otherwise:`: it can neither capture nor be invoked. To get the stock methods back, reload `System-Utilities` and `System-Utilities-Tests` from Pharo's repository, or start again from a fresh image.

## Attribution
The work is by 	Frank Shearar and	Levente Uzonyi, I just loaded in Pharo and did a little fix to make tests green.

