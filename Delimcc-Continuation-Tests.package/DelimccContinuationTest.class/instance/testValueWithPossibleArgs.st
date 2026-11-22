tests - fixes
testValueWithPossibleArgs

	| r |
	r := Continuation currentDo: [ :c |
		     k := c.
		     0 ].
	r = 0 ifTrue: [ k valueWithPossibleArgs: #( 7 8 ) ].
	self assert: r equals: 7.
	r := Continuation currentDo: [ :c |
		     k := c.
		     0 ].
	r = 0 ifTrue: [ k valueWithPossibleArgs: #(  ) ].
	self assert: r isNil