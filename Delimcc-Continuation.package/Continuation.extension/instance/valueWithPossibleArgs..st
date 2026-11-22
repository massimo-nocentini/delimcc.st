*Delimcc-Continuation-evaluating
valueWithPossibleArgs: anArray
	"Invoke the continuation with the first element of anArray, or with nil when anArray is empty, as a one-argument block answers to #valueWithPossibleArgs:."

	^ self value: (anArray isEmpty
			   ifTrue: [ nil ]
			   ifFalse: [ anArray first ])