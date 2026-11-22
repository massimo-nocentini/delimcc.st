tests - copies
testNonLocalReturnFromKInDetect
	"Review #1: the ^ of detect: runs in the block of the first invocation, which runs the contexts of the slice themselves, so its home is there."

	self
		assert: (self isolated: [ p delimit: [ #( 1 2 3 ) detect: [ :x | p shift: [ :k | k value: x = 2 ] ] ] ])
		equals: 2