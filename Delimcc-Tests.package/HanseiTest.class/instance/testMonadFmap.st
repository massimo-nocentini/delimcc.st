tests
testMonadFmap

	| tree pair |
	tree := ([ true bernoulli: 3 / 5 ] hansei fmap: [ :b | b not ])
		        inferenceExact.

	pair := tree asValuesDictionary.

	self
		assert: (pair first at: true) equals: 2 / 5;
		assert: (pair first at: false) equals: 3 / 5;
		assert: pair second size equals: 0