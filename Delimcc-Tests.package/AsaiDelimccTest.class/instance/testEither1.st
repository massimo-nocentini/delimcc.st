tests
testEither1

	| res |
	res := [
	       {
		       1.
		       (2 + 1).
		       3 } collectShift ] reset.

	self assert: res equals: #( 1 3 3 )