exploring
localProbability: pt tree: tree probability: p depth: depth upToDepth: maxDepth down: down choices: rest map: ans suspLink: susp

	| l |
	l := ValueLink new
		     value: self -> (pt * p);
		     nextLink: susp;
		     yourself.

	^ tree
		  probability: p
		  depth: depth
		  upToDepth: maxDepth
		  down: down
		  choices: rest
		  map: ans
		  suspLink: l