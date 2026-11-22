*Delimcc-Continuation-evaluating
value: anObject
	"Invoke the continuation and answer anObject as return value.

	Nothing changes when I cannot be invoked: a continuation that was never captured, or one whose stack another live process is running (see #anotherLiveProcessRunning:), signals an Error that a handler around me can catch. Both Errors are signalled with ^ from #invokeWith:unwinding:, whose answer I answer, so if a handler resumes one of them (as the debugger's Proceed does), I answer what it resumed with and the current stack goes on as if I had not been invoked.

	Otherwise the invocation abandons every frame of the current stack that is not one of mine, above the longest bottom part that the current stack and mine have in common (the whole current stack when they have none). Those frames are unwound as Exception>>#return: unwinds the frames above its handler: their ensure: and ifCurtailed: blocks run once, from the top down, and the frames are terminated. A frame below one that both stacks share is abandoned too when a sender link was rewired after I was captured, as Generator>>#next does. Then my frames get back the state they had when I was captured, and anObject is answered to the frame that captured me.

	Unlike the stock value:, an escape now runs the unwind blocks that it abandons, while a re-entry restores the frames of an ensure: as they were when I was captured, without running again what came before the ensure:. So an ensure: or a critical: that a generator or a coroutine holds across a jump runs its block at each jump out and once more at its end, and a critical: section lets other processes in between the jumps. Such code should jump with #valueWithoutUnwinding:."

	^ self invokeWith: anObject unwinding: true