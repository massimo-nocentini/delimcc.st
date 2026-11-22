*Delimcc
hanseiSuspended
	"Answer a search tree whose only branch suspends my whole model: nothing runs until the tree is explored."

	| weightedValue |
	weightedValue := DelimccWeightedValue new
		                 object:
			                 (DelimccSearchTreeNode suspended: [ self hansei ]);
		                 weight: 1;
		                 yourself.

	^ DelimccSearchTree new
		  children: weightedValue ~~> nil;
		  yourself