tests
testHanseiSuspendedDelaysTheModel

	| tree runs pair |
	runs := 0.
	tree := [
	        runs := runs + 1.
	        true bernoulli: 3 / 5 ] hanseiSuspended.

	self
		assert: runs equals: 0;
		assert: tree asValuesDictionary second size equals: 1.

	pair := tree inferenceExact asValuesDictionary.

	self
		assert: runs equals: 1;
		assert: (pair first at: true) equals: 3 / 5;
		assert: (pair first at: false) equals: 2 / 5;
		assert: pair second size equals: 0