tests - callcc
testCallCCReentersDetect
	"review-control F1a after a re-entry: the copy of the rest returns from its own copy of detect:ifNone:. n is below the reset, so the copies share it."

	| n |
	n := 0.
	self
		assert: (self isolated: [
				 [
				 | kc r |
				 r := #( 1 2 3 ) detect: [ :x |
					      ([ :k |
					       x = 2 ifTrue: [ kc := k ].
					       x ] callcc) = 2 ].
				 n := n + 1.
				 n < 3 ifTrue: [ kc value: 2 ].
				 {
					 r.
					 n } ] reset ])
		equals: #( 2 3 )