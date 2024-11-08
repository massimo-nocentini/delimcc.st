tests
testGrassModel

	| tree values pair |
	tree := [
	        | rain sprinkler grassIsWet |
	        rain := true bernoulli: 0.3.
	        sprinkler := true bernoulli: 0.5.
	        grassIsWet := (true bernoulli: 0.9) & rain or: [
		                      (true bernoulli: 0.8) & sprinkler or: [
			                      true bernoulli: 0.1 ] ].
	        grassIsWet when: [ rain ] ] hansei.

	pair := tree inferenceExact asValuesDictionary.
	values := pair first.

	self
		assert: (values at: true) equals: 0.2838;
		assert: (values at: false) equals: 0.322;
		assert: pair second size equals: 0