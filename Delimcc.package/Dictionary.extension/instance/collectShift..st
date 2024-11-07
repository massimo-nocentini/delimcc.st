*Delimcc
collectShift: aBlock

	^ [ :k |
	  | choices |
	  choices := self class new: self size.

	  self keysAndValuesDo: [ :each :weight |
		  | node |
		  node := DelimccSearchTreeNodeC new
			          slot: [
				          | newKey |
				          newKey := aBlock value: each.
				          k value: newKey ];
			          yourself.

		  choices at: node put: weight ].

	  DelimccSearchTree new
		  children: choices;
		  yourself ] shift