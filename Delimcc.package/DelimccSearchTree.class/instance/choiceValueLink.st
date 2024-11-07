accessing
choiceValueLink

	^ self children associations
		  ifEmpty: [ nil ]
		  ifNotEmpty: [ :l | l asLinkedList firstLink ]