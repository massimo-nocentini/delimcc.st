tests
testFlipRecursiveReflect

	| tree values pair count |
	count := 0.

	tree := [
	        self
		        reflectFlip: 0.6
		        remaining: 10
		        countBlock: [ count := count + 1 ] ] hansei.

	pair := tree inferenceExact asValuesDictionary.
	values := pair first.

	self
		assert: count equals: 5120;
		assert: tree inferenceExact children size equals: 1024;
		assert: (values at: true) closeTo: 0.5000000512000019;
		assert: (values at: false) closeTo: 0.49999994880000287;
		assert: pair second size equals: 0