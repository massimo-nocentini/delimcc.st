tests - fixes
testResumingTheProcessCheckErrorLeavesBothStacksAlone
	"When a handler resumes the Error of the process check, as the debugger's Proceed does, the invocation answers what the handler resumed with, and the capturer keeps its frames. The check used to signal the Error from a helper method, so a resumed Error returned into value:, which went on with the invocation: the invoker took the frames of the capturer, and the VM dropped the capturer as a zombie. The check for a continuation that was never captured behaves the same way.
	The invocation runs in its own process and the state lives in temps, as in #testInvocationWhileTheCapturerLivesSignalsError."

	| trace gate done invoked capturer invoker kk answer |
	self
		assert: ([ Continuation new value: 1 ]
				 on: Error
				 do: [ :e | e resumeUnchecked: #resumed ])
		equals: #resumed.
	trace := OrderedCollection new.
	gate := Semaphore new.
	done := Semaphore new.
	invoked := Semaphore new.
	answer := #notInvoked.
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
	           answer := [ kk value: 42 ]
		                     on: Error
		                     do: [ :e | e resumeUnchecked: #resumed ].
	           trace add: { #invoker. answer }.
	           invoked signal ] forkAt: Processor activePriority + 1.
	self deny: (invoked waitTimeoutMilliseconds: 1000).
	self assert: answer equals: #resumed.
	self deny: capturer isTerminated.
	gate signal.
	self deny: (done waitTimeoutMilliseconds: 1000).
	self
		assert: trace asArray
		equals: {
				{ #capturer. 0 }.
				{ #invoker. #resumed }.
				#capturerEnd } ] ensure: [
		{ capturer. invoker } do: [ :each |
			(each isNil or: [ each isTerminated ]) ifFalse: [
				[ each terminate ] on: Error do: [ :e | e return: nil ] ] ] ]