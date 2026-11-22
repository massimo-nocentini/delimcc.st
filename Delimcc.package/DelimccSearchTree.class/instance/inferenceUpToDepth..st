exploring
inferenceUpToDepth: maxDepth
	"Explore my branches up to maxDepth, then add up the weights of equal values, as HANSEI's insert_with (+.) does. The walk only prepends to immutable lists and the merge starts once it is over, so a continuation that captures part of the walk can be resumed more than once, and values that the worlds share are hashed in their final state."

	| explored merged choices |
	explored := self children
		            probability: 1
		            depth: 0
		            upToDepth: maxDepth
		            down: true
		            answers: nil.

	merged := OrderedDictionary new.
	explored do: [ :each |
		merged
			at: each object
			put: (merged at: each object ifAbsent: 0) + each weight ].

	choices := nil.
	merged keys reverseDo: [ :node |
		| weightedValue |
		weightedValue := DelimccWeightedValue new
			                 object: node;
			                 weight: (merged at: node);
			                 yourself.

		choices := weightedValue ~~> choices ].

	^ self class new
		  children: choices;
		  yourself