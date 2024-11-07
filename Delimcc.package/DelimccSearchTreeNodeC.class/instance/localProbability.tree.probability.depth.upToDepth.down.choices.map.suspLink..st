exploring
localProbability: pt tree: tree probability: p depth: depth upToDepth: maxDepth down: down choices: rest map: ans suspLink: susp

	^ down
		  ifTrue: [
			  | pair t |
			  t := self slot value.

			  pair := tree
				          probability: pt * p
				          depth: depth + 1
				          upToDepth: maxDepth
				          down: depth < maxDepth
				          choices: t choiceValueLink
				          map: ans
				          suspLink: susp.

			  tree
				  probability: p
				  depth: depth
				  upToDepth: maxDepth
				  down: down
				  choices: rest
				  map: pair second
				  suspLink: pair first ]
		  ifFalse: [
			  super
				  localProbability: pt
				  tree: tree
				  probability: p
				  depth: depth
				  upToDepth: maxDepth
				  down: down
				  choices: rest
				  map: ans
				  suspLink: susp ]