*Delimcc-Continuation-evaluating
cull: anObject
	"Invoke the continuation with anObject, as a one-argument block answers to #cull:, so that I can be a handler block, as in [ 1 / 0 ] on: ZeroDivide do: k, or the argument of #ifNotNil: and of the try: family."

	^ self value: anObject