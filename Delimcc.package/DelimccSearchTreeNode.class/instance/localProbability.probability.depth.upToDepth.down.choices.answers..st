exploring
localProbability: pt probability: p depth: depth upToDepth: maxDepth down: down choices: rest answers: answers

	| weightedValue |
	weightedValue := HanseiProbabilityValue new
		                 object: self;
		                 weight: pt * p;
		                 yourself.

	^ rest
		  probability: p
		  depth: depth
		  upToDepth: maxDepth
		  down: down
		  answers: weightedValue ~~> answers