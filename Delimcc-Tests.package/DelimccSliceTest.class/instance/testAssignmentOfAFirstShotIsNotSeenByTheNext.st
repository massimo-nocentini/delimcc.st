tests - temps
testAssignmentOfAFirstShotIsNotSeenByTheNext
	"x is in a temp vector of the slice, copied when the first invocation begins: what the first one assigns, the second one does not see. A heap object would be shared."

	self
		assert: [
			| v x |
			x := 0.
			v := [ :k | (k value: 1) + (k value: 2) ] shift.
			log add: x.
			[ x := v ] value.
			x ] reset
		equals: 3.
	self assert: log asArray equals: #( 0 0 )