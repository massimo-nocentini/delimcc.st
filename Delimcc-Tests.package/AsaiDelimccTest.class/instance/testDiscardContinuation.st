tests
testDiscardContinuation

	self assert: [ 2 + [ :k | 3 ] shift ] reset + 10 equals: 13