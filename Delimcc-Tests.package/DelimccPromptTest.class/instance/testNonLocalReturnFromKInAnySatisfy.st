tests - expected failures
testNonLocalReturnFromKInAnySatisfy

	self
		assert: (self isolated: [ p delimit: [ #( 1 2 3 ) anySatisfy: [ :x | p shift: [ :k | k value: x = 3 ] ] ] ])
		equals: true