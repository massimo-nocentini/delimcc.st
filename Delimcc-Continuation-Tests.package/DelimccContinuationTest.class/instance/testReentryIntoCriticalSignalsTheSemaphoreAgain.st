tests - limits
testReentryIntoCriticalSignalsTheSemaphoreAgain
	"Unchanged limit: the frames of critical: re-run their ensure: block, which signals the semaphore, but not the wait before it, so a semaphore for mutual exclusion gets one more signal per re-entry."

	| semaphore |
	semaphore := Semaphore forMutualExclusion.
	shots := 0.
	semaphore critical: [
		tmp := Continuation current.
		(tmp isKindOf: Continuation) ifTrue: [ k := tmp ] ].
	shots := shots + 1.
	shots < 3 ifTrue: [ k value: shots ].
	self assert: shots equals: 3.
	self assert: (semaphore instVarNamed: #excessSignals) equals: 3