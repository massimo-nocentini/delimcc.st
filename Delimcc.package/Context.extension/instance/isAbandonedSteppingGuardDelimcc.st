*Delimcc
isAbandonedSteppingGuardDelimcc
	"Answer whether I am a context that the debugger has inserted to step over a send (#isSteppingGuardDelimcc) for a step that cannot end through me: the context of the send, the receiver of #runUntilErrorOrReturnFrom: or #runUntilReturnFrom:, which is the outer context of the block that I run, my last argument, has returned without me, as a capture does when its k escapes. Jumping back into the debugger would end the process that runs me."

	^ self isSteppingGuardDelimcc and: [ (self tempAt: method numArgs) outerContext receiver isDead ]