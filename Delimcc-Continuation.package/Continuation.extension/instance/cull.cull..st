*Delimcc-Continuation-evaluating
cull: firstArg cull: secondArg
	"Invoke the continuation with firstArg, as a one-argument block answers to #cull:cull:."

	^ self value: firstArg