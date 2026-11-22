tests - fixes
testContinuationAsExceptionHandler

	| r |
	r := Continuation currentDo: [ :c |
		     k := c.
		     0 ].
	r = 0 ifTrue: [
		[ 1 / 0 ] on: ZeroDivide do: k.
		r := #notEscaped ].
	self assert: (r isKindOf: ZeroDivide)