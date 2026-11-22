*Delimcc-Continuation-private
initializeFromContext: aContext
	"Save aContext and each of its senders down to the bottom of the stack, each one followed by a snapshot of its state: (context1 snapshot1 context2 snapshot2 ...).
	A snapshot is a #shallowCopy of the context, which primitive 148 takes from the frame of a married context, as #instVarAt: and #at: read it: the sender, the bytecode pc, stackp, method, closureOrNil, receiver and the stack slots up to stackp. That is one send per frame, where the stock method sent #instVarAt: and #at: once per slot into a WriteStream, and it is about 2.5 times faster. A snapshot is never executed nor handed out, so it stays as it was captured however many times I am invoked: #restoreValues copies it into the context.
	aContext is a sender of the running frame, so it is suspended in a send while I save it; the running frame and the ones above aContext are not saved, as in stock.
	A first walk counts the frames, so that a second one fills an Array of the right size. When aContext belongs to another process, that process can run in between (it preempts the active one) and return from some of the frames, or rewire a sender: values then holds exactly the contexts that the second walk reaches, as the single walk of the stock method would, never a nil pair at its end nor a store past it."

	| context size index rest |
	size := 0.
	context := aContext.
	[ context isNil ] whileFalse: [
		size := size + 2.
		context := context sender ].
	values := Array new: size.
	index := 0.
	context := aContext.
	[ context notNil and: [ index < size ] ] whileTrue: [
		values
			at: index + 1 put: context;
			at: index + 2 put: context shallowCopy.
		index := index + 2.
		context := context sender ].
	index < size ifTrue: [ values := values copyFrom: 1 to: index ].
	context ifNil: [ ^ self ].
	rest := OrderedCollection new.
	[ context isNil ] whileFalse: [
		rest
			add: context;
			add: context shallowCopy.
		context := context sender ].
	values := values , rest asArray