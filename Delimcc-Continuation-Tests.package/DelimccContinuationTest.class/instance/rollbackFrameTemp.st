helpers
rollbackFrameTemp

	| n r |
	n := 0.
	shots := 0.
	r := Continuation current.
	n := n + 1.
	shots := shots + 1.
	(n < 3 and: [ shots < 3 ]) ifTrue: [ r value: r ].
	^ n