tests
testGrassModel

	| tree values pair |
	tree := [
	        self
		        grassModelPriorRain: 0.3
		        rain: 0.9
		        priorSprinkler: 0.5
		        sprinkler: 0.8
		        otherwise: 0.1 ] hansei.

	pair := tree inferenceExact asValuesDictionary.
	values := pair first.

	self
		assert: (values at: true) closeTo: 0.2838;
		assert: (values at: false) closeTo: 0.322;
		assert: pair second size equals: 0