tests - utilities
flip: p remaining: n

	^ n = 1
		  ifTrue: [ true bernoulli: p ]
		  ifFalse: [
		  (true bernoulli: 1 - p) ~= (self flip: p remaining: n - 1) ]