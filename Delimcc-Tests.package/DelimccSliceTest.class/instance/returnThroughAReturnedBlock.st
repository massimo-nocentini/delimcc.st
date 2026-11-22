helpers
returnThroughAReturnedBlock
	"The block of the slice was made by a block that has returned, whose context is its outer context: its home, this context, is found through that dead context."

	| block |
	block := [ [ :x | ^ x * 10 ] ] value.
	^ block value: [ :k | (k value: 1) + (k value: 2) ] shift