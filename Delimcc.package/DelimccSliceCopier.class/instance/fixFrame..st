copying
fixFrame: anIndex
	"Record the patches of the context at anIndex: its receiver (instance variable 6), its closure (5) and its stack slots (negative fields). They are read in its copy, which holds the same objects but is faster to read than the context, which the VM may still check against its frame, and with the accessors rather than instVarAt:, for the same reason. A temp vector is never a receiver or a closure, so the frame is current for its slots only."

	| frame code |
	frame := copies at: anIndex.
	current := 0.
	code := self codeOfReceiver: frame receiver.
	code = 0 ifFalse: [ self patch: 6 of: anIndex to: code ].
	code := self codeOfClosureOfFrame: frame closure.
	code = 0 ifFalse: [ self patch: 5 of: anIndex to: code ].
	current := anIndex.
	currentVectors := nil.
	1 to: frame stackPtr do: [ :slot |
		code := (frame at: slot) sliceCodeDelimcc: self.
		code = 0 ifFalse: [ self patch: 0 - slot of: anIndex to: code ] ]