*Delimcc
delimccDistribution: aBlock

	^ [
	  | v |
	  v := [ :k |
	       | choices |
	       choices := self
		                  collect: [ :assoc |
			                  | each prob node |
			                  each := assoc key.
			                  prob := assoc value.

			                  node := DelimccSearchTreeNodeC new
				                          slot: [ k ! each ];
				                          yourself.

			                  node -> prob ]
		                  as: LinkedList.

	       DelimccSearchTree new
		       children: choices;
		       yourself ] shift.
	  aBlock ! v ] reset