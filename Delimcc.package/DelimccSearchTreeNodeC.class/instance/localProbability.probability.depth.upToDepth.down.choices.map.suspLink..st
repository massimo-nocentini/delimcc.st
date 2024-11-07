exploring
localProbability: pt probability: p depth: depth upToDepth: maxDepth down: down choices: rest map: ans suspLink: susp

	^ down
		  ifTrue: [
			  | pair t |
			  t := self slot value.

			  pair := t choiceValueLink
				          probability: pt * p
				          depth: depth + 1
				          upToDepth: maxDepth
				          down: depth < maxDepth
				          map: ans
				          suspLink: susp.

			  rest
				  probability: p
				  depth: depth
				  upToDepth: maxDepth
				  down: down
				  map: pair second
				  suspLink: pair first ]
		  ifFalse: [
			  super
				  localProbability: pt
				  probability: p
				  depth: depth
				  upToDepth: maxDepth
				  down: down
				  choices: rest
				  map: ans
				  suspLink: susp ]