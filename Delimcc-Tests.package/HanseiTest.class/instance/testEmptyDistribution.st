tests
testEmptyDistribution

	| tree values pair |
	tree := [ {  } chooseShift ] hansei.

	pair := tree inferenceExact asValuesDictionary.
	values := pair first.

	self
		assert: values size equals: 0;
		assert: pair second size equals: 0