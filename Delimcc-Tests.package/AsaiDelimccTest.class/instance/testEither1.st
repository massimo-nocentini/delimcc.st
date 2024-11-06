tests
testEither1

	| res |
	res := [
	       {
		       1.
		       (2 + 1).
		       3 } ? [ :p | p + 1 ] ] reset.

	self
		assert: res values equals: #( 2 4 4 );
		assert: res rank equals: {
				(4 -> 0.6666666666666666).
				(2 -> 0.3333333333333333) }