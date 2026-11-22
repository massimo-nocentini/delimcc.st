helpers
rollbackInstanceVariable

	| r |
	tmp := 0.
	shots := 0.
	r := Continuation current.
	tmp := tmp + 1.
	shots := shots + 1.
	(tmp < 3 and: [ shots < 3 ]) ifTrue: [ r value: r ].
	^ tmp