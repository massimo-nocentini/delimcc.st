*Delimcc
shift
	"Cut the contexts off the call stack down to, and including, the nearest #reset, reify them as a PartialContinuation k and evaluate me with k on what is left of the stack.

k holds the delimiter, so each invocation of k is delimited again, but I am evaluated without it: this is shift0, not the shift of Danvy and Filinski. For example, [ 'a', [ [ :f | [ :g | '' ] shift ] shift ] reset ] reset answers '', where shift would answer 'a'. Hansei relies on it. I am DelimccPrompt reset shift0: self, with the capture in my own context so that k does not hold it.

The delimiter is found by walking the senders (see DelimccPrompt), so the exception handlers between me and the #reset do not see me. Signal MissingResetException when there is no #reset."

	^ self value: (DelimccPrompt reset cutSendersOf: thisContext includingDelimiter: true)