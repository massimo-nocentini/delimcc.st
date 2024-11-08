exploring
asValuesDictionaryNormalized: normalized

	| values cumulated suspended |
	suspended := Dictionary new.
	values := Dictionary new.
	cumulated := 0.0.

	self children do: [ :assoc |
		| w |
		w := assoc value.
		cumulated := cumulated + w.
		assoc key vDictionary: values cDictionary: suspended weight: w ].

	normalized ifTrue: [
		values keysAndValuesDo: [ :k :v |
			values at: k put: (v / cumulated) asFloat ].

		suspended keysAndValuesDo: [ :k :v |
			suspended at: k put: (v / cumulated) asFloat ] ].

	^ Array with: values with: suspended