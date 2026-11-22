helpers - debugger
stepOverAnEscapeIn: aBlock
	"Step a process that evaluates aBlock into every send up to its first shift, and step over that one, as the Over of the debugger does, in a process of its own: k escapes, as the shift aborts to the reset without returning through the contexts that the debugger has inserted in k, so the step does not end, and its process, which runs the rest of aBlock, ends with it."

	[
	| process context |
	process := aBlock newProcess.
	[ self is: (context := process suspendedContext) aboutToSend: #shift ] whileFalse: [ process step ].
	process completeStep: context ] forkAt: Processor activePriority + 1