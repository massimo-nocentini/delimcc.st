*Delimcc-Continuation-private
anotherLiveProcessRunning: aCollection
	"Answer a live process other than the active one whose stack holds one of the contexts in aCollection, the ones that I restore, or nil when there is none.
	Restoring my frames in place would make the active process run them, while the other process still holds them: the other process would lose its frames, and the VM would drop it as a zombie. This is the case when the process that captured me is still alive, also while another process terminates it and it runs its unwind blocks, also when another process already invoked me and is still running my frames, and also when the active process runs some of my frames and another process the others, as when a PartialContinuation of Delimcc has taken them from one process to the other.
	Process allSubInstances also answers the processes that nothing references any more, such as a capturer that suspended itself and was dropped: they can never run again, but they stay until the garbage collector runs. So when a first scan finds a process, the garbage collector runs and a second scan decides; the cost is paid only on the way to the Error.
	I only answer the process: #value: signals the Error itself, so that a handler that resumes it (as the debugger's Proceed does) returns from #value: and leaves both stacks alone.
	Only the processes are scanned, only for the captured frames that the current stack does not hold (see #invokeWith:unwinding:), and no state is recorded when I am captured."

	(self scanForAnotherProcessRunning: aCollection) ifNil: [ ^ nil ].
	Smalltalk garbageCollect.
	^ self scanForAnotherProcessRunning: aCollection