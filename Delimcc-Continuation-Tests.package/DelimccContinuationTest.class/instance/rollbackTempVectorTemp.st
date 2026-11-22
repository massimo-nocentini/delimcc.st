helpers
rollbackTempVectorTemp
	"The block that is never evaluated writes n, so n lives in a temp vector."

	| n r |
	n := 0.
	shots := 0.
	r := Continuation current.
	n := n + 1.
	shots := shots + 1.
	(n < 3 and: [ shots < 3 ]) ifTrue: [ r value: r ].
	shots = -1 ifTrue: [ [ n := 99 ] value ].
	^ n