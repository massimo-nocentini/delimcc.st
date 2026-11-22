private
freezeObjectsOf: aContext
	"Copy the temp vectors that aContext, a copy of one of my contexts, has created, as DelimccTempVectorScanner finds them, and the exceptions that it has as its receiver or in these vectors. An exception that the first invocation signals, passes or handles is the receiver of one of my contexts, #signal, #pass or #outer."

	| slots size |
	aContext receiver freezeDelimcc: self.
	slots := DelimccTempVectorScanner vectorSlotsOf: aContext method.
	slots isEmpty ifTrue: [ ^ self ].
	size := aContext stackPtr.
	slots do: [ :slot | slot <= size ifTrue: [ (aContext at: slot) ifNotNil: [ :vector | self freezeVector: vector ] ] ]