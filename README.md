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
`shift` is shift0: the continuation `k` it captures contains the delimiting `reset`, so every invocation of `k` is delimited again, but the body of the `shift` runs without it. For example, `[ 'a', [ [ :f | [ :g | '' ] shift ] shift ] reset ] reset` answers `''`, where Danvy and Filinski's shift answers `'a'`. Hansei relies on this.

`reset` marks the call stack with a `DelimccPrompt>>#delimit:` context that `shift` finds by walking the senders, and `DelimitedDynamicVariable>>#dlet:in:` does the same with a `DelimitedDynamicVariableRef`: no exception is signalled, so handlers such as `on: Exception do:` inside a `reset` or a `dlet:in:` do not interfere.

These marks replaced the exception-based machinery, which is gone: `DelimitedControlException`, `BlockClosure>>#resetContext:` and `PartialContinuation>>#copy:bottomContextDo:` were removed, and `DelimitedDynamicVariableRef` is no longer a `Notification`, so it has no `dynVar:`, `hasValue` or `handles:`, and `[ p dref ] on: p do: [ :e | ... ]` no longer intercepts the lookup of `p`.

## Attribution
The work is by 	Frank Shearar and	Levente Uzonyi, I just loaded in Pharo and did a little fix to make tests green.

