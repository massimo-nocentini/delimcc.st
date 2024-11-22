exploring
asValuesDictionaryNormalized: normalized

	| values cumulated suspended |
	suspended := Dictionary new.
	values := Dictionary new.
	cumulated := 0.

	self children do: [ :weightedValue |
		| w |
		w := weightedValue weight.
		cumulated := cumulated + w.
		weightedValue object
			vDictionary: values
			cDictionary: suspended
			weight: w ].

	normalized ifTrue: [
		values keysAndValuesDo: [ :k :v | values at: k put: v / cumulated ].

		suspended keysAndValuesDo: [ :k :v |
			suspended at: k put: v / cumulated ] ].

	^ Array with: values with: suspended