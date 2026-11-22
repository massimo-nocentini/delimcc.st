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

## Patches to Pharo's Continuation
`Delimcc-Continuation` fixes Pharo's own undelimited `Continuation` (package `System-Utilities`) with extension methods, and `Delimcc-Continuation-Tests` fixes its tests (package `System-Utilities-Tests`) the same way. Delimcc itself does not use `Continuation`. The default group loads both packages; the `Continuation` group loads only them:
```smalltalk
Metacello new
    baseline: 'Delimcc';
    repository: 'github://massimo-nocentini/delimcc.st:master';
    load: 'Continuation'
```

Methods that `Delimcc-Continuation` overrides or adds:
- `Continuation>>#value:` checks before it changes anything. A continuation that was never captured (`Continuation new value: 1`) signals an `Error`, and so does a continuation whose stack another live process is running. Stock `value:` cut the stack first, so no handler could catch the first error, and the second case made the invoking process run the frames of the other one, which the VM then dropped as a zombie. If both checks pass, `value:` unwinds only the frames it abandons, the ones above the topmost frame that the current stack shares with the captured one, as `Exception>>#return:` does. Their `ensure:` and `ifCurtailed:` blocks run once, from the top down, and the frames are terminated. Stock `value:` ran no unwind block, so an escape out of `Semaphore>>#critical:` or `Mutex>>#critical:` left the lock taken, and the abandoned frames still looked alive. Stepping over `k value:` in the debugger no longer kills the debugger's process (Pharo issue #5878): the step ends inside `value:`, when the debugger's own ensure frame is unwound.
- `Continuation>>#capturedContexts` and `Continuation>>#anotherLiveProcessRunning:` (new, private). These are the two checks above. Nothing is recorded when the continuation is captured. Only when the current stack shares no frame with the captured one does `value:` scan the live processes, looking for one whose stack holds any of the captured frames. Comparing the bottom contexts would miss a capturer that another process is terminating, because `Process>>#terminate` inserts contexts below its bottom one while its unwind blocks run. The scan only answers the process: `value:` signals both Errors itself, so if a handler resumes one of them, as the debugger's Proceed does, `value:` answers the resumed value and leaves both stacks alone.
- `Continuation>>#cull:`, `#cull:cull:`, `#cull:cull:cull:`, `#cull:cull:cull:cull:` and `#valueWithPossibleArgs:` (new). They invoke the continuation with the first argument, or with nil when there is none, as a one-argument block does. So `k` can be an exception handler (`[ 1 / 0 ] on: ZeroDivide do: k`), the argument of `ifNotNil:`, and any block of the `try:` family.
- `Continuation>>#valueWithArguments:` resumes with nil when the array is empty, as `value` does.
- `Continuation class>>#try:otherwise:` culls its try block. `try:or:otherwise:` and `try:or:or:otherwise:` pass their try block to it, so in all three the try block can now take no argument. Stock `try:otherwise:` sent it `value:`, so all three raised `ArgumentsCountMismatch` for a try block such as `[ 42 ]`.

Methods that `Delimcc-Continuation-Tests` overrides or adds:
- `TwoInARowStar>>#tree:` and `#T:` end the walk with the walker itself, not with nil, and `tree:` no longer requires the first atom to be a Symbol. So `(1 1)` and `(nil nil)` have two in a row.
- `ContinuationTest>>#remove:uptoLast:` and `#intersect:withCollection:` answer a well-formed `LinkedList` built by the new `#linkedListFrom:`. Stock answered `LinkedList with:` a chain of links: a list of nil when nothing was left, otherwise a list whose last link was its first one.
- `ContinuationTest>>#testBlockEscape`, `#testSimplestCallCC`, `#testMethodTemps`, `#testReentrant`, `#testIntersectAll`, `#testIntersectWith`, `#testLeftmost` and `#testTwoInARow` now assert what a `value:` that does not jump gets wrong. `testIntersectWith` now goes through a continuation.
- `DelimccContinuationTest` (new) tests every fix above, the API that `ContinuationTest` never runs, and the limits below.

Limits that are left as they are, because changing them would change the semantics (`DelimccContinuationTest` pins each one):
- Re-entering a frame restores the `complete` flag of a captured `ensure:` frame, so its block runs once per exit. Inside `Semaphore>>#critical:` each re-entry signals the semaphore without waiting on it first, so two processes can end up inside the critical section together.
- Exceptions are not part of the snapshot. A re-entered handler acts on the `handlerContext` that the exception has now: after an `e pass`, its `e return: v` leaves from the outer `on:do:`.
- Re-entry restores the temporaries that live in a frame, but not the ones that the compiler moves into a temp vector because a block writes them, and not instance variables. So a block that never runs can change what a re-entry sees.
- The continuation is undelimited: every capture and every invocation costs time proportional to the whole stack, and `k` keeps alive everything its frames referenced. Once the capturing process has ended, another process may invoke `k`: it abandons its own frames (their unwind blocks run) and then runs the captured frames down to the bottom of the captured process.
- A continuation captured while the debugger steps over `Continuation current` contains the contexts that the debugger inserted, so invoking it later jumps into a debugger frame that has already returned.
- `Continuation>>#terminate:` is no longer used. The class comment of `Continuation` still says nothing about these limits, because a class comment cannot be patched by an extension.

Loading `Delimcc-Continuation` replaces the methods above in place. Their package becomes the extension package, so the Monticello working copies of `System-Utilities` and `System-Utilities-Tests` show as modified. In Iceberg it depends on the Pharo version. On Pharo 12 and 13, the load adds `System-Utilities` to the modified packages of the `pharo` repository (`System-Utilities-Tests` is not one of its packages, so it does not show). On Pharo 14 and 15, Iceberg does not track `System-Utilities` (on Pharo 15 the `pharo` repository lists no packages at all), so nothing shows. Unloading the two packages (Monticello unload, or removing the packages) does not bring the stock methods back. It removes them, so `Continuation` no longer understands `value:` and `try:otherwise:`. To get the stock methods back, reload `System-Utilities` and `System-Utilities-Tests` from Pharo's repository, or start again from a fresh image.

## Attribution
The work is by 	Frank Shearar and	Levente Uzonyi, I just loaded in Pharo and did a little fix to make tests green.

