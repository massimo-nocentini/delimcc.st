codes
codeOfArray: anArray
	"R5: copy anArray when it is a temp vector of the context whose slots are being fixed, unless I share the temp vectors. A vector is in a slot of the context that created it, which is fixed before the contexts above it, so a vector that is not known by then belongs to a context below the slice, unless a context below its own refers to it: a closure of that context runs below it, as k1 does when a block of its contexts invokes it. Such a vector is shared at first, so I note that the slice is misordered, and #templateOf:for: fixes it again with its vectors registered first. A context refers to the vectors of its closure in its slots too, so only the Arrays of the slots are remembered. Its fields are fixed once every context is."

	| code |
	sharesTempVectors ifTrue: [ ^ 0 ].
	originals ifNotNil: [ (self codeOf: anArray) ifNotNil: [ :known | ^ known ] ].
	current = 0 ifTrue: [ ^ 0 ].
	(self isTempVectorOfTheCurrentFrame: anArray) ifFalse: [ ^ self shared: anArray ].
	(self isShared: anArray) ifTrue: [ misordered := true ].
	code := self register: anArray.
	(pending ifNil: [ pending := OrderedCollection new ]) add: code.
	^ code