exploring
localProbability: pt probability: p depth: depth upToDepth: maxDepth down: down choices: rest answers: answers
	"Add my mass to the answers; equal nodes add up, as HANSEI's insert_with (+.) does."

	answers at: self put: (answers at: self ifAbsent: 0) + (pt * p).

	^ rest
		  probability: p
		  depth: depth
		  upToDepth: maxDepth
		  down: down
		  answers: answers