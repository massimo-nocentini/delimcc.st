tests
testMonadGuard

	| tree |
	tree := DelimccSearchTree new return: 1.

	self
		assert: ((tree guard: true) inferenceExact asValuesDictionary first at: nil)
		equals: 1;
		assert: (tree guard: false) inferenceExact asValuesDictionary first size
		equals: 0