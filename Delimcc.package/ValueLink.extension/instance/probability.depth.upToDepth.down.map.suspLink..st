*Delimcc
probability: p depth: depth upToDepth: maxDepth down: down map: ans suspLink: susp

	| probAssoc |
	probAssoc := self value.

	^ probAssoc key
		  localProbability: probAssoc value
		  probability: p
		  depth: depth
		  upToDepth: maxDepth
		  down: down
		  choices: self nextLink
		  map: ans
		  suspLink: susp