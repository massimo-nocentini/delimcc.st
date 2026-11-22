tests - temps
testNestedResetInsideTheSlice

	self
		assert: [
			| v |
			v := [ :k | (k value: 1) + (k value: 2) ] shift.
			[ v + ([ :k2 | (k2 value: 10) * 2 ] shift) ] reset ] reset
		equals: 46