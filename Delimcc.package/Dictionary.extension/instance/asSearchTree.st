*Delimcc
asSearchTree

	| choices |
	choices := nil.

	self keysAndValuesDo: [ :each :weight |
		| node weightedValue |
		node := DelimccSearchTreeNode valued: each.

		weightedValue := DelimccWeightedValue new
			                 object: node;
			                 weight: weight;
			                 yourself.

		choices := weightedValue ~~> choices ].

	^ DelimccSearchTree new
		  children: choices;
		  yourself