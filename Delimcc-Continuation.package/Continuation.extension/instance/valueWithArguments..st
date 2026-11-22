*Delimcc-Continuation-evaluating
valueWithArguments: anArray
	"Invoke the continuation with the only element of anArray, or with nil when anArray is empty, as #value does."

	anArray size > 1 ifTrue: [
		^ self error: 'continuations can only be resumed with one argument' ].
	^ self value: (anArray isEmpty
			   ifTrue: [ nil ]
			   ifFalse: [ anArray first ])