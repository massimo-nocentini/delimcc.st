tests - fixes
testInvocationAfterTheCapturerIsUnreachable
	"The capturer suspended itself and nothing references it any more, so it can never run again: another process can invoke k, as after the capturer ended. Process allSubInstances still answers such a process until the garbage collector runs, so the check used to refuse the invocation or let it through depending on when the collector had last run.
	The capturer is not kept in a temp, and it is forked in the default execution environment: in the test environment, Process>>#on:do: puts below its bottom context a handler block whose receiver is the process, so k's own frames would keep the process reachable, and the check would rightly refuse k. The invocation runs in its own process and the state lives in temps, as in #testInvocationWhileTheCapturerLivesSignalsError."

	| trace suspended finished invoker kk caught |
	trace := OrderedCollection new.
	suspended := Semaphore new.
	finished := Semaphore new.
	caught := #notCaught.
	[
	DefaultExecutionEnvironment beActiveDuring: [
		[
		| r |
		r := Continuation currentDo: [ :c |
			     kk := c.
			     0 ].
		trace add: { #tail. r }.
		r = 0 ifTrue: [
			suspended signal.
			Processor activeProcess suspend ].
		trace add: { #end. r }.
		finished signal ] forkAt: Processor activePriority + 1 ].
	self deny: (suspended waitTimeoutMilliseconds: 1000).
	invoker := [
	           caught := [ kk value: 42 ]
		                     on: Error
		                     do: [ :e | e return: e messageText ] ]
		           forkAt: Processor activePriority + 1.
	self deny: (finished waitTimeoutMilliseconds: 1000).
	self assert: caught equals: #notCaught.
	self
		assert: trace asArray
		equals: {
				{ #tail. 0 }.
				{ #tail. 42 }.
				{ #end. 42 } } ] ensure: [
		(invoker isNil or: [ invoker isTerminated ]) ifFalse: [
			[ invoker terminate ] on: Error do: [ :e | e return: nil ] ] ]