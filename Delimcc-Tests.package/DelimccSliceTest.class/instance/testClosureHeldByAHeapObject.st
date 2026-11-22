tests - limits
testClosureHeldByAHeapObject
	"The block in held, an instance variable, is not re-pointed: its ^ works in the first invocation, which runs the contexts of the slice, and fails in the next ones, whose home it is not."

	self assert: (self isolated: [ [ self heldReturnOf: [ :k | k value: 1 ] ] reset ]) equals: 100.
	self assert: ((self isolated: [ [ self heldReturnOf: [ :k | (k value: 1) + (k value: 2) ] ] reset ]) isKindOf: BlockCannotReturn)