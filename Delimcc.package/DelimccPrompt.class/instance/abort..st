derived
abort: anObject
	"Cut the contexts from my sender down to my nearest delimiter off the stack, the delimiter too, and answer anObject to the sender of the delimiter."

	self cutSendersOf: thisContext includingDelimiter: false.
	^ anObject