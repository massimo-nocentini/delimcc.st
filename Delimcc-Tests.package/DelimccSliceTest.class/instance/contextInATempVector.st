helpers
contextInATempVector
	"here is in a temp vector, since the block reader reads it and it is assigned after."

	| here r reader |
	reader := [ here ].
	here := thisContext.
	r := [ :k | (k value: 1) + (k value: 2) ] shift.
	^ reader value == thisContext
		  ifTrue: [ r ]
		  ifFalse: [ 100 ]