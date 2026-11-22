controlling
delimiterFrom: aContext
	"Answer the nearest context, from aContext down its senders, that evaluates #delimit: on me, or nil when there is none. The selector is compared, not the method, so a continuation captured before #delimit: was recompiled still holds a delimiter."

	| context |
	context := aContext.
	[ context isNil or: [ context receiver == self and: [ context selector == #delimit: ] ] ]
		whileFalse: [ context := context sender ].
	^ context