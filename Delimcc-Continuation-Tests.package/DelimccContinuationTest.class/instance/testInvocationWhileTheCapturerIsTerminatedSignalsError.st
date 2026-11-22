tests - fixes
testInvocationWhileTheCapturerIsTerminatedSignalsError
	"Another process terminates the capturer, whose ensure: block then waits: an invocation of k meanwhile signals an Error, and the ensure: block runs once, in the capturer, and the terminator returns. Process>>#terminate runs the unwind blocks of the capturer above contexts that it inserts below the bottom one, so a check that compared the bottom contexts let the invoker run the frames of the capturer: the ensure: block ran in both processes, and the terminator never returned.
	The invocation runs in its own process and the state lives in temps, as in #testInvocationWhileTheCapturerLivesSignalsError."

	| trace gate unwinding unwound terminated invoked capturer terminator invoker kk caught |
	trace := OrderedCollection new.
	gate := Semaphore new.
	unwinding := Semaphore new.
	unwound := Semaphore new.
	terminated := Semaphore new.
	invoked := Semaphore new.
	caught := #notInvoked.
	[
	capturer := [
	            [
	            | r |
	            r := Continuation currentDo: [ :c |
		                 kk := c.
		                 0 ].
	            trace add: { #capturer. r }.
	            r = 0 ifTrue: [ gate wait ] ] ensure: [
		            trace add: #ensureStart.
		            unwinding signal.
		            unwound wait.
		            trace add: #ensureEnd ] ] forkAt: Processor activePriority + 1.
	terminator := [
	              capturer terminate.
	              trace add: #terminated.
	              terminated signal ] forkAt: Processor activePriority + 1.
	self deny: (unwinding waitTimeoutMilliseconds: 1000).
	invoker := [
	           caught := [
	                     kk value: 42.
	                     #notCaught ]
		                     on: Error
		                     do: [ :e | e return: #caught ].
	           invoked signal ] forkAt: Processor activePriority + 1.
	self deny: (invoked waitTimeoutMilliseconds: 1000).
	self assert: caught equals: #caught.
	unwound signal.
	self deny: (terminated waitTimeoutMilliseconds: 1000).
	self
		assert: trace asArray
		equals: {
				{ #capturer. 0 }.
				#ensureStart.
				#ensureEnd.
				#terminated }.
	self assert: capturer isTerminated ] ensure: [
		{ capturer. terminator. invoker } do: [ :each |
			(each isNil or: [ each isTerminated ]) ifFalse: [
				[ each terminate ] on: Error do: [ :e | e return: nil ] ] ] ]