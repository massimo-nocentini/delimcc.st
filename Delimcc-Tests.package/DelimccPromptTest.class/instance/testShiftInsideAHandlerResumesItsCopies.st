tests - expected failures
testShiftInsideAHandlerResumesItsCopies
	"Review #2: the copies of the handler return through the exception, whose handler context is the original on:do:."

	self
		assert: (self isolated: [
				 p delimit: [ ([ 1 / 0 ] on: ZeroDivide do: [ :e | p shift: [ :k | (k value: 1) + (k value: 2) ] ]) * 10 ] ])
		equals: 30