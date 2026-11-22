*Delimcc-Continuation-private
initializeFromContext: aContext
	"Save aContext and each of its senders down to the bottom of the stack, each one followed by a snapshot of its state: (context1 snapshot1 context2 snapshot2 ...).
	A snapshot is a #shallowCopy of the context, which primitive 148 takes from the frame of a married context, as #instVarAt: and #at: read it: the sender, the bytecode pc, stackp, method, closureOrNil, receiver and the stack slots up to stackp. That is one send per frame, where the stock method sent #instVarAt: and #at: once per slot into a WriteStream, and it is about 2.5 times faster. A snapshot is never executed nor handed out, so it stays as it was captured however many times I am invoked: #restoreValues copies it into the context.
	aContext is a sender of the running frame, so it is suspended in a send while I save it; the running frame and the ones above aContext are not saved, as in stock."

	| context size index |
	size := 0.
	context := aContext.
	[ context isNil ] whileFalse: [
		size := size + 2.
		context := context sender ].
	values := Array new: size.
	index := 0.
	context := aContext.
	[ context isNil ] whileFalse: [
		values
			at: index + 1 put: context;
			at: index + 2 put: context shallowCopy.
		index := index + 2.
		context := context sender ]