tests - snapshots
testSnapshotsStayPristineAcrossReentries
	"The snapshots are never executed, so every re-entry restores the frames as they were captured, although each frame changed a temporary on its way out after the previous one. The frames are those of a stack 300 frames deep that has returned, so the primitive copies each snapshot into a context that no frame holds any more."

	| r |
	log := OrderedCollection new.
	shots := 0.
	r := self captureBelow: 300.
	shots := shots + 1.
	shots < 6 ifTrue: [ k value: shots ].
	self assert: shots equals: 6.
	self assert: r equals: 5.
	self assert: log size equals: 5.
	self assert: (log allSatisfy: [ :each | each = log first ]).
	self assert: log first size > 300