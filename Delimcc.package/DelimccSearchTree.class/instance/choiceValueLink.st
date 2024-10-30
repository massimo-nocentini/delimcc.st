accessing
choiceValueLink

	^ self children
		  ifEmpty: [ nil ]
		  ifNotEmpty: [ :l | l asLinkedList firstLink ]