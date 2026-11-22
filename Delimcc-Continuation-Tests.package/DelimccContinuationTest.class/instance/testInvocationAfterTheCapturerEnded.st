tests - fixes
testInvocationAfterTheCapturerEnded
	"Once the process that captured k is over, another process can invoke k: it abandons its own frames, running their unwind blocks, and runs the tail of the captured stack down to its end."

	| done capturer invoker |
	log := OrderedCollection new.
	done := Semaphore new.
	capturer := [
	            | r |
	            r := Continuation currentDo: [ :c |
		                 k := c.
		                 0 ].
	            log add: { #tail. r. Processor activeProcess }.
	            done signal ] forkAt: Processor activePriority + 1.
	self deny: (done waitTimeoutMilliseconds: 1000).
	self assert: capturer isTerminated.
	invoker := [
	           [
	           k value: 42.
	           log add: #afterK ] ensure: [ log add: #invokerEnsure ] ]
		           forkAt: Processor activePriority + 1.
	self deny: (done waitTimeoutMilliseconds: 1000).
	self
		assert: log asArray
		equals: {
				{ #tail. 0. capturer }.
				#invokerEnsure.
				{ #tail. 42. invoker } }.
	self assert: invoker isTerminated