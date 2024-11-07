*Delimcc
asSearchTree

	| choices |
	choices := nil.

	self keysAndValuesDo: [ :each :weight |
		| node |
		node := DelimccSearchTreeNodeV new
			        slot: each;
			        yourself.

		choices := node -> weight ~~> choices ].

	^ DelimccSearchTree new
		  children: choices;
		  yourself