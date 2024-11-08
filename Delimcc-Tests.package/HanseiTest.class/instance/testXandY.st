tests
testXandY

	| tree values pair |
	tree := [
	        | p x y |
	        p := 0.6.
	        x := true bernoulli: p.
	        y := true bernoulli: p.
	        x | y when: [
		        {
			        x.
			        y } ] ] hansei.

	pair := tree inferenceExact asValuesDictionary.
	values := pair first.

	self
		assert: (values at: { true. true }) equals: 0.36;
		assert: (values at: { true. false }) equals: 0.24;
		assert: (values at: { false. true }) equals: 0.24;
		assert: pair second size equals: 0