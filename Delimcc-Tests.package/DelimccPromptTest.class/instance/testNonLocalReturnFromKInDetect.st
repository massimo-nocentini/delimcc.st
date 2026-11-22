tests - expected failures
testNonLocalReturnFromKInDetect
	"Review #1: the ^ of detect: runs in a copy of its block, whose home is the original context of detect:ifNone:."

	self
		assert: (self isolated: [ p delimit: [ #( 1 2 3 ) detect: [ :x | p shift: [ :k | k value: x = 2 ] ] ] ])
		equals: 2