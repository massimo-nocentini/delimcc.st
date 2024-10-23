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
		       (2 + 1).
		       3 } eitherDistribution.

	self
		assert: res values equals: #( 1 3 3 );
		assert: res rank equals: {
				(3 -> 0.6666666666666666).
				(1 -> 0.3333333333333333) }