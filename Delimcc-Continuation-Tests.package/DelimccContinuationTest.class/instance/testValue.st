tests - api
testValue

	| r |
	r := Continuation currentDo: [ :c |
		     k := c.
		     0 ].
	r = 0 ifTrue: [
		k value.
		r := #notEscaped ].
	self assert: r isNil