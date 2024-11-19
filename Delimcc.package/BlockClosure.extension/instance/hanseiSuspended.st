*Delimcc
hanseiSuspended

	^ [
	  | node weightedValue |
	  node := DelimccSearchTreeNode suspended: self value.

	  weightedValue := DelimccWeightedValue new
		                   object: node;
		                   weight: 1;
		                   yourself.

	  DelimccSearchTree new
		  children: weightedValue ~~> nil;
		  yourself ] reset