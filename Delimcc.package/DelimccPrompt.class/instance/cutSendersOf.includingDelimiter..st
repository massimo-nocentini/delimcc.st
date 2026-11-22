private
cutSendersOf: aContext includingDelimiter: aBoolean
	"Cut the senders of aContext down to my nearest delimiter off the stack, so that aContext returns to the sender of the delimiter, and answer them as a PartialContinuation that ends with the delimiter when aBoolean is true and above it otherwise. The delimiter is left out with the rest of the stack in that case, and no context is left when it was the sender of aContext.
Signal MissingResetException, and change nothing, when no delimiter of mine is there."

	| top delimiter above bottom |
	top := aContext sender.
	delimiter := top.
	[ delimiter isNil or: [ self isDelimiterOfMine: delimiter ] ] whileFalse: [
		above := delimiter.
		delimiter := delimiter sender ].
	delimiter ifNil: [
		^ MissingResetException new
			  prompt: self;
			  signal ].
	bottom := aBoolean
		          ifTrue: [ delimiter ]
		          ifFalse: [ above ].
	aContext privSender: delimiter sender.
	bottom ifNil: [ ^ PartialContinuation new prompt: self from: nil ].
	bottom privSender: nil.
	^ PartialContinuation new prompt: self from: top