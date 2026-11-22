tests
testMonadNodeFail

	| weightedValue pair |
	weightedValue := DelimccWeightedValue new
		                 object: ((DelimccSearchTreeNode valued: 1) fail: 'none');
		                 weight: 1;
		                 yourself.

	pair := (DelimccSearchTree new
		         children: weightedValue ~~> nil;
		         yourself) inferenceExact asValuesDictionary.

	self
		assert: pair first size equals: 0;
		assert: pair second size equals: 0