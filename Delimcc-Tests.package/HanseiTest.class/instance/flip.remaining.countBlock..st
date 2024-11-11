tests - utilities
flip: p remaining: n countBlock: cBlock

	^ n = 1
		  ifTrue: [ true bernoulli: p ]
		  ifFalse: [
			  | r s |
			  s := true bernoulli: 1 - p.
			  r := self flip: p remaining: n - 1 countBlock: cBlock.
			  cBlock value.
			  s ~= r ]