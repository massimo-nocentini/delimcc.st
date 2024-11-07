exploring
localProbability: pt tree: tree probability: p depth: depth upToDepth: maxDepth down: down choices: rest map: ans suspLink: susp

	^ tree
		  probability: p
		  depth: depth
		  upToDepth: maxDepth
		  down: down
		  choices: rest
		  map: ans
		  suspLink: self -> (pt * p) ~~> susp