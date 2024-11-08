*Delimcc
probability: p depth: depth upToDepth: maxDepth down: down answers: answers

	| probAssoc |
	probAssoc := self value.

	^ probAssoc object
		  localProbability: probAssoc weight
		  probability: p
		  depth: depth
		  upToDepth: maxDepth
		  down: down
		  choices: self nextLink
		  answers: answers