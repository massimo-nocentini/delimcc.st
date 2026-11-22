controlling
delimiterFrom: aContext
	"Answer the nearest context, from aContext down its senders, that evaluates #delimit: on me, or nil when there is none."

	| context |
	context := aContext.
	[ context isNil or: [ self isDelimiterOfMine: context ] ] whileFalse: [
		context := context sender ].
	^ context