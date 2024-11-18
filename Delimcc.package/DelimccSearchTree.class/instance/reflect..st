accessing
reflect: k

	| answers |
	answers := nil.

	self children do: [ :each |
		| node v |
		v := each object reflect: k.
		
		node := DelimccWeightedValue new
			        object: v;
			        weight: each weight;
			        yourself.

		answers := node ~~> answers ].

	^ self class new
		  children: answers;
		  yourself