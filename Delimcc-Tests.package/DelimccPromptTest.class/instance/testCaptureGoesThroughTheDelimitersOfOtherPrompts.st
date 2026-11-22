tests - tags
testCaptureGoesThroughTheDelimitersOfOtherPrompts

	"k of p holds the delimiter of q."
	self
		assert: (p delimit: [ 1 + (q delimit: [ 10 + (p shift: [ :k | k value: (k value: 100) ]) ]) ])
		equals: 122.
	self assert: (p delimit: [ 1 + (q delimit: [ 10 + (p delimit: [ 100 + (q abort: 0) ]) ]) ]) equals: 1.
	"Each invocation of k delimits with q again."
	self
		assert: (p delimit: [
				 q delimit: [
					 (p shift: [ :k | (k value: 1) + (k value: 2) ]) = 1
						 ifTrue: [ q abort: 100 ]
						 ifFalse: [ 5 ] ] ])
		equals: 105