controlling
withSubCont: aBlock
	"Cut the contexts from my sender down to my nearest delimiter off the stack, the delimiter too, and answer what aBlock answers with them as a PartialContinuation k to the sender of the delimiter. This is withSubCont of Dybvig, Peyton Jones and Sabry: aBlock is evaluated without the delimiter, and k does not hold it, so k value: x answers x to my sender undelimited."

	^ aBlock value: (self cutSendersOf: thisContext includingDelimiter: false)