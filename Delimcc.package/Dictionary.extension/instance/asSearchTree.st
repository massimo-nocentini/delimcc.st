*Delimcc
asSearchTree

	| choices |
	choices := nil.

	self keysAndValuesDo: [ :each :weight |
		| node weightedValue |
		node := DelimccSearchTreeNodeV new
			        slot: each;
			        yourself.

		weightedValue := HanseiProbabilityValue new
			                 object: node;
			                 weight: weight;
			                 yourself.

		choices := weightedValue ~~> choices ].

	^ DelimccSearchTree new
		  children: choices;
		  yourself