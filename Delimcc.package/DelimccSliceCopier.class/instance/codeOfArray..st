codes
codeOfArray: anArray
	"R5: copy anArray when it is a temp vector of the context whose slots are being fixed, unless I share the temp vectors. A vector is in a slot of the context that created it, which is fixed before the contexts above it, so a vector that is not known by then belongs to a context below the slice. Its fields are fixed once every context is."

	| code |
	sharesTempVectors ifTrue: [ ^ 0 ].
	originals == nil ifFalse: [ (self codeOf: anArray) ifNotNil: [ :known | ^ known ] ].
	(current > 0 and: [ self isTempVectorOfTheCurrentFrame: anArray ]) ifFalse: [ ^ 0 ].
	code := self register: anArray.
	(pending ifNil: [ pending := OrderedCollection new ]) add: code.
	^ code