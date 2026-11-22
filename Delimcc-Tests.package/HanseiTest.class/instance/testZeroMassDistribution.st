tests
testZeroMassDistribution

	| tree |
	tree := [ (true bernoulli: 0) when: [ 1 ] ] hansei inferenceExact.

	self
		assert: (tree mean at: 1) equals: 0;
		assert: ((tree asValuesDictionaryNormalized: true) first at: 1)
		equals: 0;
		assert: (tree printString includesSubstring: '(1 ~ 0.000)')