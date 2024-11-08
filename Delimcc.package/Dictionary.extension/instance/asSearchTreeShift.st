*Delimcc
asSearchTreeShift

	^ [ :k |
	  | choices |
	  choices := nil.

	  self keysAndValuesDo: [ :each :weight |
		  | node weightedValue |
		  node := DelimccSearchTreeNodeC new
			          slot: [ k value: each ];
			          yourself.

		  weightedValue := HanseiProbabilityValue new
			                   object: node;
			                   weight: weight;
			                   yourself.

		  choices := weightedValue ~~> choices ].

	  DelimccSearchTree new
		  children: choices;
		  yourself ] shift