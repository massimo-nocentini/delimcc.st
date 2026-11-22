tests - callcc
testCallCCReentryAfterItsReset
	"Once the reset of callcc has answered, k replaces another reset with a copy of the rest, in which the ^ of detect:ifNone: returns from its own copy."

	self
		assert: (self isolated: [
				 | kc first |
				 first := [ (#( 1 2 3 ) detect: [ :x | ([ :k | kc := k. x ] callcc) > 2 ] ifNone: [ 0 ]) + 100 ] reset.
				 {
					 first.
					 [ 1000 + (kc value: 7) ] reset.
					 [ 1000 + (kc value: 0) ] reset } ])
		equals: #( 103 103 100 )