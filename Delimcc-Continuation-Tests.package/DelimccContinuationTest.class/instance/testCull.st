tests - fixes
testCull

	| r |
	log := OrderedCollection new.
	r := Continuation currentDo: [ :c |
		     k := c.
		     0 ].
	r = 0 ifTrue: [
		5 ifNotNil: k.
		log add: #afterCull ].
	self assert: r equals: 5.
	self assert: log isEmpty.
	r := Continuation currentDo: [ :c |
		     k := c.
		     0 ].
	r = 0 ifTrue: [ k cull: 1 cull: 2 cull: 3 cull: 4 ].
	self assert: r equals: 1