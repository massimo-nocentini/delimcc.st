*Delimcc
asSearchTreeShift

	^ [ :k |
	  | choices |
	  choices := nil.

	  self keysAndValuesDo: [ :each :weight |
		  | node |
		  node := DelimccSearchTreeNodeC new
			          slot: [ k value: each ];
			          yourself.

		  choices := node -> weight ~~> choices ].

	  DelimccSearchTree new
		  children: choices;
		  yourself ] shift