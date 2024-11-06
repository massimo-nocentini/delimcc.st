*Delimcc
weightedKeysSearchTree

	^ [ :k |
	  | choices |
	  choices := LinkedList new: self size streamContents: [ :aStream |
		             self keysAndValuesDo: [ :each :weight |
			             | node |
			             node := DelimccSearchTreeNodeC new
				                     slot: [ k ! each ];
				                     yourself.

			             aStream nextPut: node -> weight ] ].

	  DelimccSearchTree new
		  children: choices;
		  yourself ] shift