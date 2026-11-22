private
framesFrom: aContext
	"Answer aContext and its senders, top first."

	| size frames context |
	size := 0.
	context := aContext.
	[ context isNil ] whileFalse: [
		size := size + 1.
		context := context sender ].
	frames := Array new: size.
	context := aContext.
	1 to: size do: [ :i |
		frames at: i put: context.
		context := context sender ].
	^ frames