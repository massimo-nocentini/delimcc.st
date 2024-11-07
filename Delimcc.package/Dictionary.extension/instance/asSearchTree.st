*Delimcc
asSearchTree

	| choices |
	choices := self class new: self size.

	self keysAndValuesDo: [ :each :weight |
		| node |
		node := DelimccSearchTreeNodeV new
			        slot: each;
			        yourself.

		choices at: node put: weight ].

	^ DelimccSearchTree new
		  children: choices;
		  yourself