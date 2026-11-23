private
snapshotOf: anObject
	"Answer the copy of anObject that my DelimccSliceSnapshot made, or anObject itself."

	^ snapshots
		  ifNil: [ anObject ]
		  ifNotNil: [ snapshots at: anObject ifAbsent: [ anObject ] ]