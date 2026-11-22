*Delimcc-Continuation-Tests-functions
remove: anObj uptoLast: aLinkedList

	^ aLinkedList ifNotEmpty: [
		  | valueLink |
		  valueLink := Continuation currentDo: [ :skip |
			               self
				               remove: anObj
				               uptoLastValueLink: aLinkedList firstLink
				               continuation: skip ].
		  self linkedListFrom: valueLink ]