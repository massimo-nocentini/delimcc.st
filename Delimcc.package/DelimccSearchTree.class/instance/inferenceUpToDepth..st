exploring
inferenceUpToDepth: maxDepth

	| answers |
	answers := self children
		           probability: 1
		           depth: 0
		           upToDepth: maxDepth
		           down: true
		           answers: nil.

	^ self class new
		  children: answers;
		  yourself