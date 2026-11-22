tests - callcc
testCallCCInAHandlerThatPasses
	"callcc in a handler that then passes or signals its exception again: each re-entry hands the copy of the exception, as it was when callcc was called, to the copy of the outer handler, even after the original has passed it (review-semantics 4). n and handled are below the reset, so the copies share them."

	#( #pass #signal ) do: [ :selector |
		| n handled |
		n := 0.
		handled := 0.
		self
			assert: (self isolated: [
					 [
					 [
					 | kc r |
					 r := [ [ 1 / 0 ] on: ZeroDivide do: [ :e |
						       [ :k | kc := k ] callcc.
						       e perform: selector ] ]
						      on: ZeroDivide
						      do: [ :e |
							      handled := handled + 1.
							      5 ].
					 n := n + 1.
					 n < 3 ifTrue: [ kc value: 0 ].
					 {
						 r.
						 n } ] reset ]
						 on: ZeroDivide
						 do: [ :e | #outside ] ])
			equals: #( 5 3 ).
		self assert: handled equals: 3 ]