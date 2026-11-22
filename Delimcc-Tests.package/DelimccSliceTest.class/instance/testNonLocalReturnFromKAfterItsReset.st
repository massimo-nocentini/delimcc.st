tests - review 1
testNonLocalReturnFromKAfterItsReset

	self
		assert: (self isolated: [
				 | k |
				 k := [ self returnOfK + 1 ] reset.
				 {
					 (k value: 1).
					 (k value: 2).
					 (k value: 3) } ])
		equals: #( 2 3 4 )