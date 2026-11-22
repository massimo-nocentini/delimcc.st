tests - basics
testWithSubContRemovesTheDelimiter
	"The block of withSubCont: runs without the delimiter, and its value is the value of the delimit:."

	self deny: (p delimit: [ 10 + (p withSubCont: [ :k | p isDelimiting ]) ]).
	self assert: (p delimit: [ 10 + (p withSubCont: [ :k | k prompt ]) ]) identicalTo: p.
	self assert: 1 + (p delimit: [ 10 + (p withSubCont: [ :k | 5 ]) ]) equals: 6