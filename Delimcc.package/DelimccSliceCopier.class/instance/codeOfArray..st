codes
codeOfArray: anArray
	"R5: copy anArray when it is a temp vector of the context being fixed. A vector is in a slot of the context that created it, which is fixed before the contexts above it, so a vector that is not known by then belongs to a context below the slice. Its fields are fixed once every context is."

	| code |
	codes == nil ifFalse: [ (codes at: anArray ifAbsent: nil) ifNotNil: [ :known | ^ known ] ].
	(current > 0 and: [ (ablated == nil or: [ self applies: #vectors ]) and: [ self isTempVectorOfTheCurrentFrame: anArray ] ])
		ifFalse: [ ^ 0 ].
	code := self register: anArray.
	(pending ifNil: [ pending := OrderedCollection new ]) add: code.
	^ code