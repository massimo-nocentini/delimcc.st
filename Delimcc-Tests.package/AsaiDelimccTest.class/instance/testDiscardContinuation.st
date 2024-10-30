tests
testDiscardContinuation

	self assert: [ 2 + [ :k | 3 ] shift ] reset + 10 equals: 3 + 10.

	self assert: [ 1 - (3 + [ :k | #hello ] shift) ] reset equals: #hello.

	self
		assert: [ 1 - (3 + (self discardDelimcc: #hello)) ] reset
		equals: #hello