private
isTempVectorOfTheCurrentFrame: anArray

	| frame slots |
	frame := copies at: current.
	slots := currentVectors ifNil: [ currentVectors := DelimccTempVectorScanner vectorSlotsOf: frame method ].
	1 to: slots size do: [ :i |
		| slot |
		slot := slots at: i.
		(slot <= frame stackPtr and: [ (frame at: slot) == anArray ]) ifTrue: [ ^ true ] ].
	^ false