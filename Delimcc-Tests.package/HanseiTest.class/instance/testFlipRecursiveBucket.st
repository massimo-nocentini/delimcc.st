tests
testFlipRecursiveBucket

	| tree values pair f p count |
	p := 0.6.
	count := 0.

	f := [ :n |
	     n = 1
		     ifTrue: [ true bernoulli: p ]
		     ifFalse: [
			     | r s |
			     r := true bernoulli: 1 - p.
			     s := f value: n - 1.
			     count := count + 1.
			     r ~= s ] ] bucket.

	tree := [ f value: 10 ] hansei.

	pair := tree inferenceExact asValuesDictionary.
	values := pair first.

	self
		assert: count equals: 2044;
		assert: tree inferenceExact children size equals: 1024;
		assert: (values at: true) equals: 0.5000000512000019;
		assert: (values at: false) equals: 0.49999994880000287;
		assert: pair second size equals: 0