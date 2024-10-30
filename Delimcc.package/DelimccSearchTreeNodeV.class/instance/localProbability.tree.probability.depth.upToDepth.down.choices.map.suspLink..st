exploring
localProbability: pt tree: tree probability: p depth: depth upToDepth: maxDepth down: down choices: rest map: ans suspLink: susp

	| v s |
	s := self slot.
	v := ans at: s ifAbsentPut: 0.0.
	ans at: s put: v + (pt * p).

	^ tree
		  probability: p
		  depth: depth
		  upToDepth: maxDepth
		  down: down
		  choices: rest
		  map: ans
		  suspLink: susp