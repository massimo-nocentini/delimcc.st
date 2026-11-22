tests - review 2
testClosureOfAnExceptionIsPointedToItsCopy
	"The block of DelimccTestError>>#answer: exists when the shift captures, and its receiver is the exception, which the handler slice copies: the copy of the block is re-pointed to the copy of the exception, so each invocation returns from its own handler (R3, review-perf 4c)."

	self
		assert: (self isolated: [
				 [
				 [ DelimccTestError new signal ]
					 on: DelimccTestError
					 do: [ :e | e answer: [ [ :k | (k value: 1) + (k value: 2) ] shift ] ] ] reset ])
		equals: 30