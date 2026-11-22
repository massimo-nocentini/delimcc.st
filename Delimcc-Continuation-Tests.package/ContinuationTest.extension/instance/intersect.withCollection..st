*Delimcc-Continuation-Tests-functions
intersect: aLinkedList withCollection: aCollection

	^ aLinkedList ifNotEmpty: [
		  self linkedListFrom: (self
				   intersectValueLink: aLinkedList firstLink
				   withCollection: aCollection) ]