exploring
average

	| values cumulated |
	values := Dictionary new.
	cumulated := 0.

	self children do: [ :weightedValue |
		| w |
		w := weightedValue weight.
		cumulated := cumulated + w.

		weightedValue object
			vDictionary: values
			cDictionary: values
			weight: w ].

	values keysAndValuesDo: [ :k :v | values at: k put: v / cumulated ].

	^ values