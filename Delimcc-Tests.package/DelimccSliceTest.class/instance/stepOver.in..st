helpers - debugger
stepOver: aSelector in: aBlock
	"Step a process that evaluates aBlock into every send up to the first send of aSelector, step over that send, as the Over of the debugger does (Process>>#completeStep:), step into the rest, and answer what aBlock answers."

	| result process context |
	result := #unfinished.
	process := [ result := aBlock value ] newProcess.
	[ self is: (context := process suspendedContext) aboutToSend: aSelector ] whileFalse: [ process step ].
	process completeStep: context.
	self stepToTheEnd: process.
	^ result