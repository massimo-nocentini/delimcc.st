private
bindingIfNone: aBlock
	"Answer my innermost binding on the call stack, or the value of aBlock when there is none. The senders are walked and compared by identity, without signalling: no exception handler can answer in my place, and nil is a value like any other."

	| during context |
	during := DelimitedDynamicVariableRef >> #during:.
	context := thisContext.
	[ context isNil ] whileFalse: [
		(context method == during and: [ context receiver dynVar == self ])
			ifTrue: [ ^ context receiver ].
		context := context sender ].
	^ aBlock value