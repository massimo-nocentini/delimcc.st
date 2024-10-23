tests
testEither

	| res |
	res := [
	       self delimccEither: {
			       1.
			       (2 + 2).
			       3 } ] reset.

	self assert: res equals: #( 1 4 3 ).

	res := {
		       1.
		       (2 + 2).
		       3 } ? [ :p | p ].
	self assert: res equals: #( 1 4 3 )