codes
codeOfException: anException
	"R4: copy anException when one of its instance variables is one of my contexts, as my DelimccSliceSnapshot copied it if it did. Its fields are fixed once every context is, as they may refer to anything."

	| code |
	originals == nil ifFalse: [ (self codeOf: anException) ifNotNil: [ :known | ^ known ] ].
	(self refersToAFrame: (self snapshotOf: anException)) ifFalse: [ ^ 0 ].
	code := self register: anException.
	(pending ifNil: [ pending := OrderedCollection new ]) add: code.
	^ code