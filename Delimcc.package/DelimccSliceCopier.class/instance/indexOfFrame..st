private
indexOfFrame: anObject
	"Answer the index of anObject among my contexts, or 0. A short slice is searched, a long one indexed; either way anObject is compared by identity, so it may be anything."

	| size |
	size := frames size.
	size > 16 ifTrue: [ ^ (frameIndexes ifNil: [ self indexFrames ]) at: anObject ifAbsent: [ 0 ] ].
	1 to: size do: [ :i | (frames at: i) == anObject ifTrue: [ ^ i ] ].
	^ 0