copying
registerTempVectors
	"Copy the temp vectors that each of my contexts has created (R5) before any context is fixed, so that a context below the owner of a vector finds the copy too (#codeOfArray:)."

	frames size to: 1 by: -1 do: [ :i |
		| frame |
		frame := copies at: i.
		current := i.
		currentVectors := nil.
		(DelimccTempVectorScanner vectorSlotsOf: frame method) do: [ :slot |
			slot <= frame stackPtr ifTrue: [ (frame at: slot) sliceCodeDelimcc: self ] ] ].
	current := 0