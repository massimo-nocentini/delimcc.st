tests
testDrunkCoinModel

	| tree values pair |
	tree := [
	        | rain |
	        rain := self drunkCoin: 10 ] hansei.

	pair := tree inferenceExact asValuesDictionary.
	values := pair first.

	self
		assert: (values at: true) equals: 9.765624999999978e-14;
		assert: (values at: false) equals: 0.05263157894736328;
		assert: pair second size equals: 0