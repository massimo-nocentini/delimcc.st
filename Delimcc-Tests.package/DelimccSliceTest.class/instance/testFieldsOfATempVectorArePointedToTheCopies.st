tests - temps
testFieldsOfATempVectorArePointedToTheCopies
	"A temp vector of the slice that holds a ^ block or thisContext is copied with its fields re-pointed to the copies: each invocation returns from its own copy of the home of the block, and finds its own context (review-perf 4a)."

	self assert: (self isolated: [ [ self returnThroughATempVector ] reset ]) equals: 30.
	self assert: (self isolated: [ [ self contextInATempVector ] reset ]) equals: 3