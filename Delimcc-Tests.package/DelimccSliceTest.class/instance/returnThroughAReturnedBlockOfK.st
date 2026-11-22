helpers
returnThroughAReturnedBlockOfK
	"As #returnThroughAReturnedBlock, with k answered by the reset."

	| block |
	block := [ [ :x | ^ x * 10 ] ] value.
	^ block value: [ :k | k ] shift