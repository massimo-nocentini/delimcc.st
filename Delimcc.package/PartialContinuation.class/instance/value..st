evaluating
value: anObject
	"Copy the contexts of the continuation and stitch them onto the current call 
	stack by telling the bottom context that thisContext's sender called it. 
	'thisContext sender' because thisContext refers to the context of the #value: call."

	| topContext bottomContext |
	bottomContext := nil.

	topContext := self
		              copy: self context
		              to: nil
		              bottomContextDo: [ :bc | bottomContext := bc ]. "copy the whole stack"

	bottomContext swapSender: thisContext sender.
	"Tell thisContext that its sender was actually the last/top-most context."
	thisContext swapSender: topContext.
	"Finally, 'return' anObject from the caller context... which thanks to the line
	above, is actually values first. This effectively sets anObject as the parameter
	to the reified partial continuation, because instead of 'returning' to our caller
	we 'return' to the next part of the computation - our
	partial-continuation-as-function."
	^ anObject