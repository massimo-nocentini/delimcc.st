exploring
localProbability: pt probability: p depth: depth upToDepth: maxDepth down: down choices: rest answers: answers

	^ down
		  ifTrue: [
			  | moreAnswers |
			  moreAnswers := self children
				                 probability: pt * p
				                 depth: depth + 1
				                 upToDepth: maxDepth
				                 down: depth < maxDepth
				                 answers: answers.

			  rest
				  probability: p
				  depth: depth
				  upToDepth: maxDepth
				  down: down
				  answers: moreAnswers ]
		  ifFalse: [
			  super
				  localProbability: pt
				  probability: p
				  depth: depth
				  upToDepth: maxDepth
				  down: down
				  choices: rest
				  answers: answers ]