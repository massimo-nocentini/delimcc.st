tests
testBernoulli

	| tree values pair |
	tree := [ true bernoulli: 0.6 ] hansei.

	pair := tree inferenceExact asValuesDictionary.
	values := pair first.

	self
		assert: (values at: true) equals: 0.6;
		assert: (values at: false) equals: 0.4;
		assert: pair second size equals: 0.

	self
		assert: (tree inferenceExact mean
				 foldr: [ :v :p :m | v asInteger * p + m ]
				 init: 0)
		closeTo: 0.6