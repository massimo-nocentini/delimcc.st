monad
>>= aBlock

	| otherChildren |
	otherChildren := nil.

	self children do: [ :each |
		| node |
		node := DelimccWeightedValue new
			        object: each object >>= aBlock;
			        weight: each weight;
			        yourself.

		otherChildren := node ~~> otherChildren ].

	^ self class new
		  children: otherChildren;
		  yourself