private
snapshotOf: anObject
	"Answer the copy of anObject that my DelimccSliceSnapshot made, or anObject itself."

	snapshots == nil ifTrue: [ ^ anObject ].
	^ snapshots at: anObject ifAbsent: [ anObject ]