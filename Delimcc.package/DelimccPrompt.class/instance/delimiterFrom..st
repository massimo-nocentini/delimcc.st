controlling
delimiterFrom: aContext
	"Answer the nearest context, from aContext down its senders, that evaluates #delimit: on me, or nil when there is none."

	| delimit context |
	delimit := DelimccPrompt >> #delimit:.
	context := aContext.
	[ context isNil or: [ context method == delimit and: [ context receiver == self ] ] ]
		whileFalse: [ context := context sender ].
	^ context