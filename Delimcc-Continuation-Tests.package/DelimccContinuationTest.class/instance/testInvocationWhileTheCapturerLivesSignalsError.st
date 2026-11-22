tests - fixes
testInvocationWhileTheCapturerLivesSignalsError
	"k belongs to the stack of a process that still waits in it: invoking k from this process signals an Error and leaves both processes alone. A stock invocation made this process run the tail of the other one, which the VM then dropped as a zombie."

	| gate done capturer caught |
	log := OrderedCollection new.
	gate := Semaphore new.
	done := Semaphore new.
	capturer := [
	            | r |
	            r := Continuation currentDo: [ :c |
		                 k := c.
		                 0 ].
	            log add: { #capturer. r }.
	            r = 0 ifTrue: [ gate wait ].
	            log add: #capturerEnd.
	            done signal ] forkAt: Processor activePriority + 1.
	caught := [
	          k value: 42.
	          #notCaught ]
		          on: Error
		          do: [ :e | e return: #caught ].
	self assert: caught equals: #caught.
	self deny: capturer isTerminated.
	gate signal.
	self deny: (done waitTimeoutMilliseconds: 1000).
	self
		assert: log asArray
		equals: {
				{ #capturer. 0 }.
				#capturerEnd }