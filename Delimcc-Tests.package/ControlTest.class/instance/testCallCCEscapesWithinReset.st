tests
testCallCCEscapesWithinReset

	self assert: [ 10 + ([ :k | 1 + (k value: 3) ] callcc) ] reset equals: 13.
	self assert: [ 10 + ([ :k | 5 ] callcc) ] reset equals: 15