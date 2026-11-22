helpers
returnThroughAnIfAbsentBlock
	"The same shape as #returnThroughAReturnedBlock, from an ordinary idiom: a block answered by an ifAbsent: block."

	| block |
	block := Dictionary new at: #missing ifAbsent: [ [ :x | ^ x * 10 ] ].
	^ block value: [ :k | (k value: 1) + (k value: 2) ] shift