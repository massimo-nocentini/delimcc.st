exploring
localProbability: pt tree: tree probability: p depth: depth upToDepth: maxDepth down: down choices: rest map: ans suspLink: susp

	^ down
		  ifTrue: [
			  | dw l |
			  dw := maxDepth ifNil: [ true ] ifNotNil: [ depth < maxDepth ].

			  l := tree
				       probability: pt * p
				       depth: depth + 1
				       upToDepth: maxDepth
				       down: dw
				       choices: self slot value choiceValueLink
				       map: ans
				       suspLink: susp.

			  tree
				  probability: p
				  depth: depth
				  upToDepth: maxDepth
				  down: down
				  choices: rest
				  map: ans
				  suspLink: l ]
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