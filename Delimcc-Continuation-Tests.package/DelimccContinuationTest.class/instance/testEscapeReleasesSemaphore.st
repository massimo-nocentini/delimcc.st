tests - fixes
testEscapeReleasesSemaphore
	"A stock escape left the semaphore without its signal, so the next critical: waited forever."

	| r semaphore |
	semaphore := Semaphore forMutualExclusion.
	r := Continuation currentDo: [ :c |
		     k := c.
		     0 ].
	r = 0 ifTrue: [ semaphore critical: [ k value: 1 ] ].
	self assert: r equals: 1.
	self deny: (semaphore waitTimeoutMilliseconds: 200).
	semaphore signal