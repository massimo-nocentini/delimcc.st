helpers
framesBelow: aContext
	"Answer the method, pc, stackp and stack slots of aContext and of each of its senders."

	| context frames |
	frames := OrderedCollection new.
	context := aContext.
	[ context isNil ] whileFalse: [
		frames add: {
				context method.
				context pc.
				context stackPtr.
				((1 to: context size) collect: [ :i | context at: i ]) }.
		context := context sender ].
	^ frames asArray