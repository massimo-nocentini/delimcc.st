*Delimcc
chooseShift

	^ [ :k |
	  | choices |
	  choices := nil.

	  self keysAndValuesDo: [ :each :weight |
		  | node weightedValue |
		  node := DelimccSearchTreeNode suspended: [ k value: each ].

		  weightedValue := DelimccWeightedValue new
			                   object: node;
			                   weight: weight;
			                   yourself.

		  choices := weightedValue ~~> choices ].

	  DelimccSearchTree new
		  children: choices;
		  yourself ] shift