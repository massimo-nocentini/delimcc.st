helpers
returnFromAFrameOfAReturnedBlock
	"A frame of the slice runs a block made by a block that has returned, and returns from its home, this context."

	| block |
	block := [ [ :x | ^ x * ([ :k | (k value: 1) + (k value: 2) ] shift) ] ] value.
	block value: 10.
	^ 0