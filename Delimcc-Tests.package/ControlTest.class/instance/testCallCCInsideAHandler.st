tests
testCallCCInsideAHandler
	"After callcc, a handler block must go on on the original stack, the only place from which it can return to its on:do:. On a copy it leaves through a shift instead, because returning from there would terminate the process."

	#( 5 1 ) do: [ :n |
		self
			assert: [
				[ 1 / 0 ] on: ZeroDivide do: [ :e |
					| here sum |
					here := thisContext.
					sum := [ :k | k value: n. 5 ] callcc.
					thisContext == here
						ifTrue: [ sum + 1 ]
						ifFalse: [ [ :k | #copy ] shift ] ] ] reset
			equals: n + 1 ]