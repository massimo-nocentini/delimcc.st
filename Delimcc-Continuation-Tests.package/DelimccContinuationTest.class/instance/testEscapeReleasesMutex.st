tests - fixes
testEscapeReleasesMutex
	"A stock escape left the mutex owned by this process, so no other process could enter it."

	| r mutex entered done |
	mutex := Mutex new.
	r := Continuation currentDo: [ :c |
		     k := c.
		     0 ].
	r = 0 ifTrue: [ mutex critical: [ k value: 1 ] ].
	entered := false.
	done := Semaphore new.
	[
	mutex critical: [ entered := true ].
	done signal ] forkAt: Processor activePriority + 1.
	done waitTimeoutMilliseconds: 1000.
	self assert: r equals: 1.
	self assert: entered