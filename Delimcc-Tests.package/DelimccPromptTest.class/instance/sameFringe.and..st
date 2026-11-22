helpers
sameFringe: aTree and: anotherTree
	"Walk both trees in step, with a generator on p and one on q, until their leaves differ."

	| left right |
	left := self generatorOn: aTree prompt: p.
	right := self generatorOn: anotherTree prompt: q.
	[ left isNil or: [ right isNil ] ] whileFalse: [
		left first = right first ifFalse: [ ^ false ].
		left := self next: left prompt: p.
		right := self next: right prompt: q ].
	^ left isNil and: [ right isNil ]