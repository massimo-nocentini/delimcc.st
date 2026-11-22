derived
shift0: aBlock
	"Cut the contexts from my sender down to my nearest delimiter off the stack, and answer what aBlock answers with them as a PartialContinuation k to the sender of the delimiter. k ends with the delimiter, so each invocation of k is delimited again, but aBlock is evaluated without it: this is shift0. BlockClosure>>#shift is DelimccPrompt reset shift0:."

	^ aBlock value: (self cutSendersOf: thisContext includingDelimiter: true)