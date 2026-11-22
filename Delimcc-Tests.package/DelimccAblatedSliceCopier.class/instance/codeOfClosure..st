codes
codeOfClosure: aClosure

	^ rule == #closures
		  ifTrue: [ 0 ]
		  ifFalse: [ super codeOfClosure: aClosure ]