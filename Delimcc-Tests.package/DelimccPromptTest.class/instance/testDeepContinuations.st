tests - machine
testDeepContinuations

	| deep |
	deep := nil.
	deep := [ :n |
	        n = 0
		        ifTrue: [ p shift: [ :k | (k value: 1) + (k value: 2) ] ]
		        ifFalse: [ 1 + (deep value: n - 1) ] ].
	self assert: (p delimit: [ deep value: 10000 ]) equals: 20003.
	self assert: (p delimit: [ deep value: 100000 ]) equals: 200003