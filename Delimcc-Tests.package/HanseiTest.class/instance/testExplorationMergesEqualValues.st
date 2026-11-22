tests
testExplorationMergesEqualValues

	| tree weights |
	tree := [ (true bernoulli: 1 / 2) | (true bernoulli: 1 / 2) ] hansei
		        inferenceExact.

	weights := Dictionary new.
	tree children do: [ :each | weights at: each object slot put: each weight ].

	self
		assert: tree children size equals: 2;
		assert: (weights at: true) equals: 3 / 4;
		assert: (weights at: false) equals: 1 / 4