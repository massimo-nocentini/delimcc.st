exploring
asValuesDictionary

	| values |
	values := Dictionary new.

	self children do: [ :assoc |
		assoc key
			vDictionary: values
			cDictionary: Dictionary new
			weight: assoc value ].

	^ values