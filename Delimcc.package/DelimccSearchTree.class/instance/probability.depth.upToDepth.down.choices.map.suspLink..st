exploring
probability: p depth: depth upToDepth: maxDepth down: down choices: choicesLink map: ans suspLink: susp

	^ choicesLink ifNil: [ susp ] ifNotNil: [
		  | probAssoc |
		  probAssoc := choicesLink value.

		  probAssoc key
			  localProbability: probAssoc value
			  tree: self
			  probability: p
			  depth: depth
			  upToDepth: maxDepth
			  down: down
			  choices: choicesLink nextLink
			  map: ans
			  suspLink: susp ]