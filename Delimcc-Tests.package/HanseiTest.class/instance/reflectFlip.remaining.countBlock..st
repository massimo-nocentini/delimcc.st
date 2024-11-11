tests - utilities
reflectFlip: p remaining: n countBlock: cBlock

	^ n = 1
		  ifTrue: [ true bernoulli: p ]
		  ifFalse: [
			  | r s |
			  r := [ self flip: p remaining: n - 1 countBlock: cBlock ] hansei
				       inferenceExact reflect.

			  s := true bernoulli: 1 - p.

			  cBlock value.

			  s ~= r ]