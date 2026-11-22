private
isTempVectorOfTheCurrentFrame: anArray

	| frame |
	frame := copies at: current.
	^ (currentVectors ifNil: [ currentVectors := DelimccTempVectorScanner vectorSlotsOf: frame method ])
		  anySatisfy: [ :slot | slot <= frame stackPtr and: [ (frame at: slot) == anArray ] ]