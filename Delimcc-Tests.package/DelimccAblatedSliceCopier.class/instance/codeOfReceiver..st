codes
codeOfReceiver: anObject

	^ rule == #receivers
		  ifTrue: [ 0 ]
		  ifFalse: [ super codeOfReceiver: anObject ]