*Delimcc
shift
	"Cut contexts off the call stack down to (but not including) the nearest #reset, and reify this partial continuation as a function. Then, pass this function to aUnaryBlock."

	| cc currentCtxt fun resetCtxt |
	resetCtxt := DelimitedControlException signal ifNil: [
		             ^ MissingResetException signal ].

	"resetCtxt is not where we want to cut. Because we use #on:do: to mark the stack, 
	rather than marking the reset's context directly, it's the marked context that we 
	want to leave on the stack. We need to cut to the context whose sender is resetCtxt."

	currentCtxt := thisContext.

	cc := currentCtxt findContextSuchThat: [ :each |
		      each size > 0 and: [ (each at: 1) == resetCtxt ] ].

	cc := cc sender.

	"Store the stack from _below_ the shift to just _below_ the reset marker."
	fun := PartialContinuation new
		       from: currentCtxt sender downTo: cc;
		       yourself.

	"Throw away the stack down to just _above_ the reset marker."
	currentCtxt swapSender: cc.

	^ self value: fun