tests - basics
testWithSubContExcludesTheDelimiter
	"k is the contexts from the sender of withSubCont: down to the delimiter, which it does not hold."

	| k |
	k := p delimit: [ 1 + (p withSubCont: [ :kk | kk ]) ].
	self assert: k stack size equals: 1.
	self deny: (k stack anySatisfy: [ :each | each selector == #delimit: ]).
	self assert: (k value: 41) equals: 42.
	self assert: (k pushSubCont: [ 1 + 1 ]) equals: 3.
	self assert: ((1 to: 1000) collect: [ :i | k value: i ]) equals: (2 to: 1001) asArray