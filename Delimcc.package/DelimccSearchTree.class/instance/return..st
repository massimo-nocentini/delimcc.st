monad
return: anObject

	| node |
	node := HanseiProbabilityValue new
		        object: (DelimccSearchTreeNode valued: anObject);
		        weight: 1;
		        yourself.

	^ self class new
		  children: node ~~> nil;
		  yourself