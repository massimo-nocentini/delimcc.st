tests - callcc
testCallCCCopiesShareTheTempVectors
	"n is in a temp vector of the reset block, since a block writes it: the copies of callcc share it with the contexts that go on running and with each other, so each re-entry counts on from the last one (D5, review-perf 4b)."

	| guard |
	guard := 0.
	self
		assert: (self isolated: [
				 [
				 | n kc |
				 n := 0.
				 [ :k |
				 kc := k.
				 0 ] callcc.
				 [ n := n + 1 ] value.
				 guard := guard + 1.
				 (n < 3 and: [ guard < 10 ]) ifTrue: [ kc value: 1 ].
				 {
					 n.
					 guard } ] reset ])
		equals: #( 3 3 )