tests - snapshots
testReentryAfterGarbageCollection
	"A full garbage collection and a scavenge between the capture and the re-entry move the snapshots and the contexts; the re-entry still restores the frames as they were captured."

	| r |
	log := OrderedCollection new.
	shots := 0.
	r := self captureBelow: 100.
	shots := shots + 1.
	shots = 1 ifTrue: [ Smalltalk garbageCollect ].
	shots = 2 ifTrue: [ Smalltalk garbageCollectMost ].
	shots < 3 ifTrue: [ k value: shots ].
	self assert: shots equals: 3.
	self assert: r equals: 2.
	self assert: log size equals: 2.
	self assert: log first equals: log last