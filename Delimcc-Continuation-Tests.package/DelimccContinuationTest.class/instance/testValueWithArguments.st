tests - fixes
testValueWithArguments
	"valueWithArguments: #() resumes with nil, as value does; more than one argument signals an Error before anything changes."

	| r |
	r := Continuation currentDo: [ :c |
		     k := c.
		     0 ].
	r = 0 ifTrue: [ k valueWithArguments: #( 7 ) ].
	self assert: r equals: 7.
	r := Continuation currentDo: [ :c |
		     k := c.
		     0 ].
	r = 0 ifTrue: [ k valueWithArguments: #(  ) ].
	self assert: r isNil.
	self should: [ k valueWithArguments: #( 1 2 ) ] raise: Error