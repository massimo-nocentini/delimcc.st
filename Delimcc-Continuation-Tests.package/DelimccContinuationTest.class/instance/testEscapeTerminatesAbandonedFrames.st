tests - fixes
testEscapeTerminatesAbandonedFrames
	"The frames that an escape leaves are terminated, as an exception that returns from its handler terminates them; a stock escape left them with their pc."

	| r |
	r := Continuation currentDo: [ :c |
		     k := c.
		     0 ].
	r = 0 ifTrue: [ self frameThatInvokesK ].
	self assert: r equals: 1.
	self assert: frame isDead.
	self assert: frame sender isNil