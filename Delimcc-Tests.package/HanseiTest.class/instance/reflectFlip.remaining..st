tests - utilities
reflectFlip: p remaining: n

	^ n = 1
		  ifTrue: [ true bernoulli: p ]
		  ifFalse: [
			  | r |
			  r := [ self flip: p remaining: n - 1 ] hansei inferenceExact
				       reflect.

			  (true bernoulli: 1 - p) ~= r ]