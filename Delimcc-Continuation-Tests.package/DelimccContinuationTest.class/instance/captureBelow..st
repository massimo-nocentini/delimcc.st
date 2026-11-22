helpers
captureBelow: n
	"Capture k n frames deeper and answer 0; when k is invoked later, log the frames below the capturing one and answer the invocation value from there."

	^ self depth: n do: [
		  | r |
		  r := Continuation currentDo: [ :c |
			       k := c.
			       0 ].
		  r = 0 ifFalse: [ log add: (self framesBelow: thisContext sender) ].
		  r ]