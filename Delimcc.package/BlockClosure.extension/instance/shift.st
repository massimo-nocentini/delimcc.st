*Delimcc
shift
	"Cut the contexts off the call stack down to, and including, the nearest #reset, reify them as a PartialContinuation k and evaluate me with k on what is left of the stack.

k holds the delimiter, so each invocation of k is delimited again, but I am evaluated without it: this is shift0, not the shift of Danvy and Filinski. For example, [ 'a', [ [ :f | [ :g | '' ] shift ] shift ] reset ] reset answers '', where shift would answer 'a'. Hansei relies on it.

The delimiter is found by walking the senders (see DelimccPrompt), so the exception handlers between me and the #reset do not see me. Signal MissingResetException when there is no #reset."

	| delimiter k |
	delimiter := (DelimccPrompt reset delimiterFrom: thisContext sender)
		             ifNil: [ ^ MissingResetException signal ].

	k := PartialContinuation new
		     from: thisContext sender downTo: delimiter sender;
		     yourself.

	"Return to the sender of the delimiter, the context of #reset."
	thisContext swapSender: delimiter sender.

	^ self value: k