helpers - debugger
stepToTheEnd: aProcess

	| steps |
	steps := 0.
	[ aProcess isTerminated or: [ aProcess suspendedContext isNil or: [ steps > 1000000 ] ] ] whileFalse: [
		aProcess step.
		steps := steps + 1 ]