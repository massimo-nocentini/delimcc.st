helpers
invokeKForTheDebugger
	"The debugger in #testSteppingOverAnInvocationInTheDebugger steps over the k value: send of this method, and into everything else."

	| r |
	r := Continuation currentDo: [ :c |
		     k := c.
		     0 ].
	shots := shots + 1.
	r = 0 ifTrue: [ k value: 7 ].
	^ r
