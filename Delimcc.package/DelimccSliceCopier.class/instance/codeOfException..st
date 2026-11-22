codes
codeOfException: anException
	"R4: copy anException when one of its instance variables is one of my contexts. Its fields are fixed once every context is, as they may refer to anything."

	| code |
	(ablated == nil or: [ self applies: #exceptions ]) ifFalse: [ ^ 0 ].
	originals == nil ifFalse: [ (self codeOf: anException) ifNotNil: [ :known | ^ known ] ].
	(self refersToAFrame: anException) ifFalse: [ ^ 0 ].
	code := self register: anException.
	(pending ifNil: [ pending := OrderedCollection new ]) add: code.
	^ code