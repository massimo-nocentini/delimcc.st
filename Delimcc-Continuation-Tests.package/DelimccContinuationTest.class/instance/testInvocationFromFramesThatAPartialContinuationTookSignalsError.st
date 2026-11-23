tests - fixes
testInvocationFromFramesThatAPartialContinuationTookSignalsError
	"A PartialContinuation of Delimcc has cut the captured frames above its delimiter off the stack of the capturer, which still waits in the frames below, and another process runs them through k: invoking the continuation from inside them signals an Error, although the invoker then shares those frames with the captured stack, and leaves both processes alone. Without the check, the invoker ran the tail of the capturer while the capturer was still alive.
	The test is skipped when Delimcc is not loaded, as with the group Continuation."

	| prompt trace gate done invoked capturer invoker kk cont caught |
	prompt := (Smalltalk globals at: #DelimccPrompt ifAbsent: [ ^ self skip: 'Delimcc is not loaded' ]) named: 'p'.
	trace := OrderedCollection new.
	gate := Semaphore new.
	done := Semaphore new.
	invoked := Semaphore new.
	caught := #notInvoked.
	[
	capturer := [
	            | r |
	            r := prompt delimit: [
		                 | x |
		                 x := Continuation currentDo: [ :c |
			                      cont := c.
			                      0 ].
		                 x = 0
			                 ifTrue: [
				                 prompt withSubCont: [ :k |
					                 kk := k.
					                 #cut ] ]
			                 ifFalse: [ x ] ].
	            trace add: { #capturer. r }.
	            gate wait.
	            trace add: #capturerEnd.
	            done signal ] forkAt: Processor activePriority + 1.
	self assert: trace asArray equals: { { #capturer. #cut } }.
	invoker := [
	           caught := [
	                     kk pushSubCont: [ cont value: 42 ].
	                     #notCaught ]
		                     on: Error
		                     do: [ :e | e return: e messageText ].
	           invoked signal ] forkAt: Processor activePriority + 1.
	self deny: (invoked waitTimeoutMilliseconds: 1000).
	self assert: (caught includesSubstring: 'another live process').
	self deny: capturer isTerminated.
	gate signal.
	self deny: (done waitTimeoutMilliseconds: 1000).
	self
		assert: trace asArray
		equals: {
				{ #capturer. #cut }.
				#capturerEnd } ] ensure: [
		{ capturer. invoker } do: [ :each |
			(each isNil or: [ each isTerminated ]) ifFalse: [
				[ each terminate ] on: Error do: [ :e | e return: nil ] ] ] ]