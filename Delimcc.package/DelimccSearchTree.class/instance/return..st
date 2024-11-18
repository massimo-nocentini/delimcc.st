monad
return: anObject

	| node |
	node := DelimccWeightedValue new
		        object: (DelimccSearchTreeNode valued: anObject);
		        weight: 1;
		        yourself.

	^ self class new
		  children: node ~~> nil;
		  yourself