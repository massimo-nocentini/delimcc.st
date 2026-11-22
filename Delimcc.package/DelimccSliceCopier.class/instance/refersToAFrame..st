private
refersToAFrame: anObject

	1 to: anObject class instSize do: [ :i |
		| value |
		value := anObject instVarAt: i.
		(value isContext and: [ (self codeOfContext: value) > 0 ]) ifTrue: [ ^ true ] ].
	^ false