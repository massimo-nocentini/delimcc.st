private
bindingIfNone: aBlock
	"Answer my innermost binding on the call stack, or the value of aBlock when there is none. The senders are walked, without signalling: no exception handler can answer in my place, and nil is a value like any other. The selector of #during: is compared, not its method, so a continuation captured before it was recompiled keeps its bindings."

	| context |
	context := thisContext.
	[ context isNil ] whileFalse: [
		(context receiver class == DelimitedDynamicVariableRef and: [
			 context receiver dynVar == self and: [ context selector == #during: ] ])
			ifTrue: [ ^ context receiver ].
		context := context sender ].
	^ aBlock value