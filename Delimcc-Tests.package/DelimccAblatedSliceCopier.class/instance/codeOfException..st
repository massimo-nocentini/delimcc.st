codes
codeOfException: anException

	^ rule == #exceptions
		  ifTrue: [ 0 ]
		  ifFalse: [ super codeOfException: anException ]