tests - fixes
testContinuationAsTryBlocks
	"k can be the otherwise: block, which is culled with the result, and an or: block, which is culled with its own continuation first."

	| r |
	r := Continuation currentDo: [ :c |
		     k := c.
		     0 ].
	r = 0 ifTrue: [
		Continuation try: [ :local | local value: 3 ] otherwise: k.
		r := #notEscaped ].
	self assert: r equals: 3.
	r := Continuation currentDo: [ :c |
		     k := c.
		     0 ].
	r = 0 ifTrue: [
		Continuation
			try: [ :local | local value: 3 ]
			or: k
			otherwise: [ :a :b | #else ].
		r := #notEscaped ].
	self assert: (r isKindOf: Continuation)