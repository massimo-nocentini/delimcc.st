exploring
localProbability: pt probability: p depth: depth upToDepth: maxDepth down: down choices: rest answers: answers

	^ rest
		  probability: p
		  depth: depth
		  upToDepth: maxDepth
		  down: down
		  answers: self -> (pt * p) ~~> answers