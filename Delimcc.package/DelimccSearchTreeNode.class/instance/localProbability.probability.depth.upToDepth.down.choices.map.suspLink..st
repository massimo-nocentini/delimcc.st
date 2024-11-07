exploring
localProbability: pt probability: p depth: depth upToDepth: maxDepth down: down choices: rest map: ans suspLink: susp

	^ rest
		  probability: p
		  depth: depth
		  upToDepth: maxDepth
		  down: down
		  map: ans
		  suspLink: self -> (pt * p) ~~> susp