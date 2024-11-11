tests
testFlipRecursiveBucket

	| tree values pair f p |
	p := 0.6.

	f := [ :n |
	     n = 1
		     ifTrue: [ true bernoulli: p ]
		     ifFalse: [ (true bernoulli: 1 - p) ~= (f value: n - 1) ] ]
		     bucket.

	tree := [ f value: 10 ] hansei.

	pair := tree inferenceExact asValuesDictionary.
	values := pair first.

	self
		assert: (values at: true) equals: 0.5000000512000019;
		assert: (values at: false) equals: 0.49999994880000287;
		assert: pair second size equals: 0