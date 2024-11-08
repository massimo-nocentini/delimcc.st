*Delimcc
probability: p depth: depth upToDepth: maxDepth down: down answers: answers

	| probAssoc |
	probAssoc := self value.

	^ probAssoc key
		  localProbability: probAssoc value
		  probability: p
		  depth: depth
		  upToDepth: maxDepth
		  down: down
		  choices: self nextLink
		  answers: answers