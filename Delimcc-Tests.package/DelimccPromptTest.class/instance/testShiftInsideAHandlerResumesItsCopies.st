tests - copies
testShiftInsideAHandlerResumesItsCopies
	"Review #2: the second invocation returns through its copy of the exception, whose handler context is its copy of the on:do: context."

	self
		assert: (self isolated: [
				 p delimit: [ ([ 1 / 0 ] on: ZeroDivide do: [ :e | p shift: [ :k | (k value: 1) + (k value: 2) ] ]) * 10 ] ])
		equals: 30