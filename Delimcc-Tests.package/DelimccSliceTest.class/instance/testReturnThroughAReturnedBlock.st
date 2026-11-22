tests - review 1
testReturnThroughAReturnedBlock
	"A ^ in a block made by a block that has returned returns from the copy of its home in each invocation, whether a frame of the slice holds the block or runs it (review-semantics 2)."

	self assert: (self isolated: [ [ self returnThroughAReturnedBlock ] reset ]) equals: 30.
	self assert: (self isolated: [ [ self returnThroughTwoReturnedBlocks ] reset ]) equals: 30.
	self assert: (self isolated: [ [ self returnFromAFrameOfAReturnedBlock ] reset ]) equals: 30.
	self assert: (self isolated: [ [ self returnThroughAnIfAbsentBlock ] reset ]) equals: 30