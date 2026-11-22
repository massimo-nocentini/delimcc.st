tests - review 1
testAnySatisfyOfThreeShots

	self
		assert: (self isolated: [
				 [
				 (#( 1 2 3 ) anySatisfy: [ :x | [ :k | (k value: false) | (k value: true) ] shift ])
					 ifTrue: [ 1 ]
					 ifFalse: [ 0 ] ] reset ])
		equals: 1