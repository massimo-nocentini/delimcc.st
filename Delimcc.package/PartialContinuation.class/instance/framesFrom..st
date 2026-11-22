private
framesFrom: aContext
	"Answer aContext and its senders, top first, in one walk: reading the sender of a context that was on the stack is slower than growing an Array."

	| frames size context |
	frames := Array new: 8.
	size := 0.
	context := aContext.
	[ context isNil ] whileFalse: [
		size = frames size ifTrue: [ frames := frames grownBy: size ].
		frames at: (size := size + 1) put: context.
		context := context sender ].
	^ frames first: size