testing
hasACopyOfEach: someContexts
	"Answer whether my contexts are copies of each of someContexts, the contexts that I was made from, which they are unless I have left out stepping guards (DelimccSliceCopier>>#leaveOutSteppingGuards)."

	^ frames size = someContexts size