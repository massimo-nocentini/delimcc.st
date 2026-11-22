tests - fixes
testInvocationWhileAnotherInvokerRunsTheFramesSignalsError
	"The process that captured k is over, but another process invoked k and still waits in the captured frames: a second invocation signals an Error, and the first invoker then finishes normally. A check that only looked at the capturing process would let the second invoker take the frames away from the first one.
	Each invocation runs in its own process and the state lives in temps, as in #testInvocationWhileTheCapturerLivesSignalsError."

	| trace gate done invoked capturer firstInvoker secondInvoker kk caught |
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
	            trace add: { #tail. r }.
	            r = 42 ifTrue: [ gate wait ].
	            trace add: { #end. r }.
	            done signal ] forkAt: Processor activePriority + 1.
	self deny: (done waitTimeoutMilliseconds: 1000).
	self assert: capturer isTerminated.
	firstInvoker := [ kk value: 42 ] forkAt: Processor activePriority + 1.
	self deny: firstInvoker isTerminated.
	secondInvoker := [
	                 caught := [
	                           kk value: 9.
	                           #notCaught ]
		                           on: Error
		                           do: [ :e | e return: e messageText ].
	                 invoked signal ] forkAt: Processor activePriority + 1.
	self deny: (invoked waitTimeoutMilliseconds: 1000).
	self assert: (caught includesSubstring: 'another live process').
	self deny: firstInvoker isTerminated.
	gate signal.
	self deny: (done waitTimeoutMilliseconds: 1000).
	self
		assert: trace asArray
		equals: {
				{ #tail. 0 }.
				{ #end. 0 }.
				{ #tail. 42 }.
				{ #end. 42 } }.
	self assert: firstInvoker isTerminated ] ensure: [
		{ capturer. firstInvoker. secondInvoker } do: [ :each |
			(each isNil or: [ each isTerminated ]) ifFalse: [
				[ each terminate ] on: Error do: [ :e | e return: nil ] ] ] ]
