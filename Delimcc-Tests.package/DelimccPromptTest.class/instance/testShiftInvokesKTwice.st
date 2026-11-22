tests - derived
testShiftInvokesKTwice

	self assert: 1 + (p delimit: [ 10 + (p shift: [ :k | k value: (k value: 100) ]) ]) equals: 121.
	self assert: 1 + (p delimit: [ 10 + (p shift0: [ :k | k value: (k value: 100) ]) ]) equals: 121.
	self assert: 1 + (p delimit: [ 10 + (p control: [ :k | k value: (k value: 100) ]) ]) equals: 121.
	self assert: 1 + (p delimit: [ 10 + (p control0: [ :k | k value: (k value: 100) ]) ]) equals: 121