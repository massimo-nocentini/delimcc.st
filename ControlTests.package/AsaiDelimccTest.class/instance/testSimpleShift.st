tests
testSimpleShift

	self
		assert: [ 2 * [ :k | k value: (k value: 10) ] shift ] reset + 1
		equals: 41