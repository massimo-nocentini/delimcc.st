tests
testFlipRecursive

	| tree values pair |
	tree := [ self flip: 0.6 remaining: 10 ] hansei.

	pair := tree inferenceExact asValuesDictionary.
	values := pair first.

	self
		assert: (values at: true) equals: 0.5000000512000019;
		assert: (values at: false) equals: 0.49999994880000287;
		assert: pair second size equals: 0