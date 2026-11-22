exploring
inferenceUpToDepth: maxDepth

	| answers choices |
	answers := self children
		           probability: 1
		           depth: 0
		           upToDepth: maxDepth
		           down: true
		           answers: OrderedDictionary new.

	choices := nil.

	answers keysAndValuesDo: [ :node :weight |
		| weightedValue |
		weightedValue := DelimccWeightedValue new
			                 object: node;
			                 weight: weight;
			                 yourself.

		choices := weightedValue ~~> choices ].

	^ self class new
		  children: choices;
		  yourself