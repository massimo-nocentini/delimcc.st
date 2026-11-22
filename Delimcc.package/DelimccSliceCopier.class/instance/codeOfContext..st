codes
codeOfContext: aContext
	"Answer the index of aContext among my contexts, or 0. A short slice is searched, a long one indexed."

	| size |
	size := frames size.
	size > 16 ifTrue: [ ^ (frameIndexes ifNil: [ self indexFrames ]) at: aContext ifAbsent: [ 0 ] ].
	1 to: size do: [ :i | (frames at: i) == aContext ifTrue: [ ^ i ] ].
	^ 0