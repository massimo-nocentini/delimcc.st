evaluating
value: anObject
	"Run a copy of my contexts on top of the current call stack, anObject being the answer of the capture that reified me, and answer what they answer. The contexts are copied at each invocation, so I can be invoked many times."

	self insertCopyBelow: thisContext.
	^ anObject