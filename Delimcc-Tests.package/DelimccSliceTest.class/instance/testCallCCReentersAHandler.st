tests - callcc
testCallCCReentersAHandler
	"review-control F1x after a re-entry: the copy of the handler returns to its own copy of the on:do: context. n is below the reset, so the copies share it."

	| n |
	n := 0.
	self
		assert: (self isolated: [
				 [
				 [
				 | kc r |
				 r := [ 1 / 0 ] on: ZeroDivide do: [ :e |
					      ([ :k |
					       kc := k.
					       5 ] callcc) + 1 ].
				 n := n + 1.
				 n < 3 ifTrue: [ kc value: 5 ].
				 {
					 r.
					 n } ] reset ]
					 on: Error
					 do: [ :e | #caught ] ])
		equals: #( 6 3 )