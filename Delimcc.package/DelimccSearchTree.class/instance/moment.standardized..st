exploring
moment: n standardized: standardize

	| values cumulated suspended |
	suspended := Dictionary new.
	values := Dictionary new.
	cumulated := 0.

	self children do: [ :weightedValue |
		| w o |
		w := weightedValue weight.
		cumulated := cumulated + w.

		o := weightedValue object.

		n > 1 ifTrue: [ o := o - n raisedTo: n ].

		o vDictionary: values cDictionary: suspended weight: w ].


	values keysAndValuesDo: [ :k :v |
		values at: k put: (v / cumulated) asFloat ].

	suspended keysAndValuesDo: [ :k :v |
		suspended at: k put: (v / cumulated) asFloat ].

	^ Array with: values with: suspended