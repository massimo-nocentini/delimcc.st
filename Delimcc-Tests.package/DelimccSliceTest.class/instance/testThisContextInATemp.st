tests - temps
testThisContextInATemp

	self
		assert: [
			| c |
			c := thisContext.
			[ :k | (k value: 1) + (k value: 2) ] shift.
			c == thisContext
				ifTrue: [ 1 ]
				ifFalse: [ 100 ] ] reset
		equals: 2