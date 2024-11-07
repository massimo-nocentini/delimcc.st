exploring
probability: p depth: depth upToDepth: maxDepth down: down choices: choicesLink map: ans suspLink: susp

	^ choicesLink ifNil: [ susp ] ifNotNil: [
		  | node pt rest probAssoc |
		  probAssoc := choicesLink value.

		  node := probAssoc key.
		  pt := probAssoc value.

		  rest := choicesLink nextLink.

		  node
			  localProbability: pt
			  tree: self
			  probability: p
			  depth: depth
			  upToDepth: maxDepth
			  down: down
			  choices: rest
			  map: ans
			  suspLink: susp ]