*Delimcc
hansei

	^ [
	  DelimccSearchTree new
		  children: (Dictionary new
				   at: (DelimccSearchTreeNodeV new
						    slot: self value;
						    yourself)
				   put: 1.0;
				   yourself);
		  yourself ] reset