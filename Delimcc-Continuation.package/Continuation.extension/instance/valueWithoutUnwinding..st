*Delimcc-Continuation-evaluating
valueWithoutUnwinding: anObject
	"Invoke the continuation and answer anObject as return value, as #value: does, with the same checks, but the frames that the invocation abandons are only terminated: their ensure: and ifCurtailed: blocks do not run, as with the stock value:.
	This is the jump for generators and coroutines, whose abandoned frames are re-entered later through another continuation: an ensure: or a critical: held across such jumps then runs its block once, when it completes, and a critical: section stays closed to other processes between the jumps. The frames that are never re-entered keep their unwind blocks unrun."

	^ self invokeWith: anObject unwinding: false