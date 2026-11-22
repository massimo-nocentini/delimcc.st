*Delimcc-Continuation-private
signalIfAnotherProcessRuns: aContext
	"Signal an Error if a live process other than the active one runs the stack whose bottom context is aContext, the bottom one of my stack.
	Restoring my frames in place would make the active process run them, while the other process still holds them: the other process would lose its frames, and the VM would drop it as a zombie. This is the case when the process that captured me is still alive, and also when another process already invoked me and is still running my frames.
	Only the processes are scanned, only when the current stack shares no frame with mine, and no state is recorded when I am captured."

	| active |
	active := Processor activeProcess.
	Process allSubInstancesDo: [ :each |
		(each ~~ active and: [
			 each isTerminated not and: [
				 each suspendedContext notNil and: [
					 each suspendedContext bottomContext == aContext ] ] ])
			ifTrue: [
				^ self error:
					  'This continuation belongs to the stack of another live process: '
					  , each printString ] ]