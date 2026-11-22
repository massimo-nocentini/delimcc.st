helpers
returnThroughTwoReturnedBlocks
	"As #returnThroughAReturnedBlock, with two dead contexts between the block and its home."

	| block |
	block := [ [ [ :x | ^ x * 10 ] ] value ] value.
	^ block value: [ :k | (k value: 1) + (k value: 2) ] shift