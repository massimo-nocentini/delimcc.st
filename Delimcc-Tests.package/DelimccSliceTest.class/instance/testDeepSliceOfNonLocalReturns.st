tests - review 1
testDeepSliceOfNonLocalReturns
	"100000 levels, each with a block whose ^ returns from the copy of its home."

	self
		assert: (self isolated: [
				 | k |
				 k := [ self deepReturns: 100000 ] reset.
				 {
					 (k value: 1).
					 (k value: 2) } ])
		equals: #( 100001 100002 )