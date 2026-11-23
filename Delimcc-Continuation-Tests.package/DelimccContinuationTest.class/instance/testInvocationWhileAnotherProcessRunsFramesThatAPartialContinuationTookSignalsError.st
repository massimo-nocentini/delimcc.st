tests - fixes
testInvocationWhileAnotherProcessRunsFramesThatAPartialContinuationTookSignalsError
	"A PartialContinuation of Delimcc has cut the captured frames above its delimiter off the stack of the capturer, and another process waits in them, inside the first invocation of k: the capturer, which still holds the frames below and so shares them with the captured stack, signals an Error when it invokes the continuation, and the other process then finishes normally. Without the check, the capturer ran the frames that the other process held, which then failed with BlockCannotReturn once resumed.
	The test is skipped when Delimcc is not loaded, as with the group Continuation."

	| prompt trace gate runnerGate done runnerDone capturer runner kk cont caught |
	prompt := (Smalltalk globals at: #DelimccPrompt ifAbsent: [ ^ self skip: 'Delimcc is not loaded' ]) named: 'p'.
	trace := OrderedCollection new.
	gate := Semaphore new.
	runnerGate := Semaphore new.
	done := Semaphore new.
	runnerDone := Semaphore new.
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
	            r == #cut ifTrue: [
		            gate wait.
		            caught := [
		                      cont value: 7.
		                      #notCaught ]
			                      on: Error
			                      do: [ :e | e return: e messageText ].
		            trace add: #capturerEnd ].
	            done signal ] forkAt: Processor activePriority + 1.
	runner := [
	          trace add: { #runner. kk pushSubCont: [
			          runnerGate wait.
			          #fromRunner ] }.
	          runnerDone signal ] forkAt: Processor activePriority + 1.
	self deny: runner isTerminated.
	gate signal.
	self deny: (done waitTimeoutMilliseconds: 1000).
	self assert: (caught includesSubstring: 'another live process').
	runnerGate signal.
	self deny: (runnerDone waitTimeoutMilliseconds: 1000).
	self
		assert: trace asArray
		equals: {
				{ #capturer. #cut }.
				#capturerEnd.
				{ #runner. #fromRunner } } ] ensure: [
		{ capturer. runner } do: [ :each |
			(each isNil or: [ each isTerminated ]) ifFalse: [
				[ each terminate ] on: Error do: [ :e | e return: nil ] ] ] ]