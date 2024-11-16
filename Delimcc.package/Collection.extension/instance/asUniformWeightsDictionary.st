*Delimcc
asUniformWeightsDictionary

	| dict p |
	dict := Dictionary new: self size.

	self ifNotEmpty: [
		p := 1 / self size.

		self do: [ :each |
			| v |
			v := dict at: each ifAbsent: 0.
			dict at: each put: v + p ] ].

	^ dict