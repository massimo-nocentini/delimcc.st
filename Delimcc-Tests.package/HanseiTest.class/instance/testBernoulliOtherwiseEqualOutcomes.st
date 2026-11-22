tests
testBernoulliOtherwiseEqualOutcomes

	| pair |
	pair := [ 1 bernoulli: 3 / 10 otherwise: 1 ] hansei inferenceExact
		        asValuesDictionary.

	self
		assert: pair first size equals: 1;
		assert: (pair first at: 1) equals: 1;
		assert: pair second size equals: 0