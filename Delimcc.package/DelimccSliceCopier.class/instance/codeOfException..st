codes
codeOfException: anException
	"R4: copy anException when one of its instance variables is one of my contexts. Its fields are fixed once every context is, as they may refer to anything."

	| code |
	(ablated == nil or: [ self applies: #exceptions ]) ifFalse: [ ^ 0 ].
	codes == nil ifFalse: [ (codes at: anException ifAbsent: nil) ifNotNil: [ :known | ^ known ] ].
	((1 to: anException class instSize) anySatisfy: [ :i |
		 | value |
		 value := anException instVarAt: i.
		 value isContext and: [ (self codeOfContext: value) > 0 ] ]) ifFalse: [ ^ 0 ].
	code := self register: anException.
	(pending ifNil: [ pending := OrderedCollection new ]) add: code.
	^ code