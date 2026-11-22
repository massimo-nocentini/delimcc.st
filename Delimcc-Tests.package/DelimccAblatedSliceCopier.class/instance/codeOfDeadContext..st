codes
codeOfDeadContext: aContext

	^ rule == #deadContexts
		  ifTrue: [ 0 ]
		  ifFalse: [ super codeOfDeadContext: aContext ]