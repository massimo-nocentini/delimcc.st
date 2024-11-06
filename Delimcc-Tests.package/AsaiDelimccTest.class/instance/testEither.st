tests
testEither

	| res |
	res := [
	       {
		       1.
		       (2 + 2).
		       3 } collectShift ] reset.

	self assert: res equals: #( 1 4 3 )