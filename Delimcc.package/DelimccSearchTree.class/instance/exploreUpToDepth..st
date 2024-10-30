exploring
exploreUpToDepth: maxDepth

	^ self
		  probability: 1.0
		  depth: 0
		  upToDepth: maxDepth
		  down: true
		  choices: self choiceValueLink
		  map: Dictionary new
		  suspLink: nil