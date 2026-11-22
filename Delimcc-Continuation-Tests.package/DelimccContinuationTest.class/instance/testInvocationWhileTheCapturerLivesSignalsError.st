tests - fixes
testInvocationWhileTheCapturerLivesSignalsError
	"k belongs to the stack of a process that still waits in it: invoking k from another process signals an Error and leaves both processes alone. A stock invocation made the invoker run the tail of the capturer, which the VM then dropped as a zombie.
	The invocation runs in its own process and the state lives in temps, so if the check is lost, the invoker, not the process that runs the tests, is the one that runs the captured frames, and this test fails instead of stopping the run."

	| trace gate done invoked capturer invoker kk caught |
	trace := OrderedCollection new.
	gate := Semaphore new.
	done := Semaphore new.
	invoked := Semaphore new.
	caught := #notInvoked.
	[
	capturer := [
	            | r |
	            r := Continuation currentDo: [ :c |
		                 kk := c.
		                 0 ].
	            trace add: { #capturer. r }.
	            r = 0 ifTrue: [ gate wait ].
	            trace add: #capturerEnd.
	            done signal ] forkAt: Processor activePriority + 1.
	invoker := [
	           caught := [
	                     kk value: 42.
	                     #notCaught ]
		                     on: Error
		                     do: [ :e | e return: #caught ].
	           invoked signal ] forkAt: Processor activePriority + 1.
	self deny: (invoked waitTimeoutMilliseconds: 1000).
	self assert: caught equals: #caught.
	self deny: capturer isTerminated.
	gate signal.
	self deny: (done waitTimeoutMilliseconds: 1000).
	self
		assert: trace asArray
		equals: {
				{ #capturer. 0 }.
				#capturerEnd } ] ensure: [
		{ capturer. invoker } do: [ :each |
			(each isNil or: [ each isTerminated ]) ifFalse: [
				[ each terminate ] on: Error do: [ :e | e return: nil ] ] ] ]
