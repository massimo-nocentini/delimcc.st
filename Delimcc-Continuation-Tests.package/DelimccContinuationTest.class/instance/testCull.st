tests - fixes
testCull
	"Every cull: arity resumes with its first argument, as a one-argument block answers it, and the code after the send does not run."

	| r |
	log := OrderedCollection new.
	r := Continuation currentDo: [ :c |
		     k := c.
		     0 ].
	r = 0 ifTrue: [
		5 ifNotNil: k.
		log add: #afterIfNotNil ].
	self assert: r equals: 5.
	r := Continuation currentDo: [ :c |
		     k := c.
		     0 ].
	r = 0 ifTrue: [
		k cull: 1.
		log add: #afterCull ].
	self assert: r equals: 1.
	r := Continuation currentDo: [ :c |
		     k := c.
		     0 ].
	r = 0 ifTrue: [
		k cull: 2 cull: 20.
		log add: #afterCullCull ].
	self assert: r equals: 2.
	r := Continuation currentDo: [ :c |
		     k := c.
		     0 ].
	r = 0 ifTrue: [
		k cull: 3 cull: 30 cull: 300.
		log add: #afterCullCullCull ].
	self assert: r equals: 3.
	r := Continuation currentDo: [ :c |
		     k := c.
		     0 ].
	r = 0 ifTrue: [
		k cull: 4 cull: 40 cull: 400 cull: 4000.
		log add: #afterCullCullCullCull ].
	self assert: r equals: 4.
	self assert: log isEmpty
