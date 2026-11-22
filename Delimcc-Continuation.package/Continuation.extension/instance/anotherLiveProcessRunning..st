*Delimcc-Continuation-private
anotherLiveProcessRunning: aCollection
	"Answer a live process other than the active one whose stack holds one of the contexts in aCollection, the ones that I restore, or nil when there is none.
	Restoring my frames in place would make the active process run them, while the other process still holds them: the other process would lose its frames, and the VM would drop it as a zombie. This is the case when the process that captured me is still alive, also while another process terminates it and it runs its unwind blocks, and also when another process already invoked me and is still running my frames.
	I look for my frames anywhere on the stack of each process, not only at its bottom: Process>>#terminate inserts contexts below the bottom context of a process that it terminates from another process.
	I only answer the process: #value: signals the Error itself, so that a handler that resumes it (as the debugger's Proceed does) returns from #value: and leaves both stacks alone.
	Only the processes are scanned, only when the current stack shares no frame with mine, and no state is recorded when I am captured."

	| active |
	active := Processor activeProcess.
	Process allSubInstancesDo: [ :each |
		(each ~~ active and: [
			 each isTerminated not and: [
				 each suspendedContext notNil and: [
					 (each suspendedContext findContextSuchThat: [ :context |
						  aCollection includes: context ]) notNil ] ] ])
			ifTrue: [ ^ each ] ].
	^ nil