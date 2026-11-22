evaluating
value: anObject
	"Run my contexts on top of the current call stack, anObject being the answer of the capture that reified me, and answer what they answer."

	self insertBelow: thisContext.
	^ anObject