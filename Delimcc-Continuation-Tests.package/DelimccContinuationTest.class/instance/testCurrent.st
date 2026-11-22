tests - api
testCurrent

	| r |
	shots := 0.
	r := Continuation current.
	shots := shots + 1.
	shots < 3 ifTrue: [ r value: r ].
	self assert: shots equals: 3.
	self assert: (r isKindOf: Continuation)