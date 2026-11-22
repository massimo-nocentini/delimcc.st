tests - review 2
testDeepSlicesOfHandlersAreSnapshotted
	"A slice deeper than 16 contexts keeps a DelimccSliceSnapshot at its first invocation, which is fixed at the second: its temp vectors and the exceptions that it signals or handles are as they were when the first invocation began, so each invocation retries with n at 1, and passes or goes outer from the handler that the exception had then, not from the one that the first invocation passed it to (testRetryAfterReentry and testPassAndOuterAfterReentry, 20 contexts deeper)."

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
						 self twoShotsAt: 20.
						 e retry ] ] reset ])
		equals: 4.
	self
		assert: (self isolated: [
				 [
				 [
				 [ 1 / 0 ]
					 on: ZeroDivide
					 do: [ :e |
						 self twoShotsAt: 20.
						 e pass ] ]
					 on: ZeroDivide
					 do: [ :e | -1 ] ] reset ])
		equals: -2.
	self
		assert: (self isolated: [
				 [
				 [
				 [ (Warning signal: 'w') + 10 ]
					 on: Warning
					 do: [ :e |
						 | v |
						 v := self twoShotsAt: 20.
						 e resume: e outer + v - 10 ] ]
					 on: Warning
					 do: [ :e | e resume: 5 ] ] reset ])
		equals: 53