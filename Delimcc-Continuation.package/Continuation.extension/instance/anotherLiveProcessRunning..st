*Delimcc-Continuation-private
anotherLiveProcessRunning: aContext
	"Answer a live process other than the active one that runs the stack whose bottom context is aContext, the bottom one of my stack, or nil when there is none.
	Restoring my frames in place would make the active process run them, while the other process still holds them: the other process would lose its frames, and the VM would drop it as a zombie. This is the case when the process that captured me is still alive, and also when another process already invoked me and is still running my frames.
	I only answer the process: #value: signals the Error itself, so that a handler that resumes it (as the debugger's Proceed does) returns from #value: and leaves both stacks alone.
	Only the processes are scanned, only when the current stack shares no frame with mine, and no state is recorded when I am captured."

	| active |
	active := Processor activeProcess.
	Process allSubInstancesDo: [ :each |
		(each ~~ active and: [
			 each isTerminated not and: [
				 each suspendedContext notNil and: [
					 each suspendedContext bottomContext == aContext ] ] ])
			ifTrue: [ ^ each ] ].
	^ nil