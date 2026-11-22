tests - review 2
testRetryAfterReentry
	"n is in a temp vector of the slice: each invocation retries with its own copy, so the second one counts from 0 too."

	self
		assert: (self isolated: [
				 [
				 | n |
				 n := 0.
				 [
				 n := n + 1.
				 n < 2 ifTrue: [ 1 / 0 ].
				 n ]
					 on: ZeroDivide
					 do: [ :e |
						 [ :k | (k value: 1) + (k value: 2) ] shift.
						 e retry ] ] reset ])
		equals: 4