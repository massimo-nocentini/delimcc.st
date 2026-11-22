tests - review 1
testDetectIfNoneOfTwoShots

	self
		assert: (self isolated: [ [ #( 1 2 3 ) detect: [ :x | [ :k | (k value: true) + (k value: false) ] shift ] ifNone: [ 0 ] ] reset ])
		equals: 6