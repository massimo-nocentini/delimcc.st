exploring
probability: p depth: depth upToDepth: maxDepth down: down choices: choicesLink map: ans suspLink: susp

	^ choicesLink ifNil: [ Array with: susp with: ans ] ifNotNil: [
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