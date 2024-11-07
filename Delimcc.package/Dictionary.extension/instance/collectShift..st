*Delimcc
collectShift: aBlock

	^ [ :k |
	  | choices |
	  choices := nil.

	  self keysAndValuesDo: [ :each :weight |
		  | node |
		  node := DelimccSearchTreeNodeC new
			          slot: [
				          | newKey |
				          "newKey := aBlock value: each."
				          k value: each ];
			          yourself.

		  choices := node -> weight ~~> choices ].

	  DelimccSearchTree new
		  children: choices;
		  yourself ] shift