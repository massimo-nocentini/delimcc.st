tests - review 1
testHanseiModelWithDetect

	self
		assert: (self isolated: [ ([ #( 1 2 3 ) detect: [ :x | true bernoulli: 1 / 2 ] ifNone: [ 0 ] ] hansei inferenceExact) asValuesDictionary first ])
		equals: (Dictionary newFromPairs: {
					 1. (1 / 2).
					 2. (1 / 4).
					 3. (1 / 8).
					 0. (1 / 8) })