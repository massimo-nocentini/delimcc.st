*Delimcc
asSearchTree

	| choices p |
	choices := Dictionary new: self size.

	p := 1.0 / self size asFloat.

	self do: [ :each |
		| v |
		v := choices at: each ifAbsent: 0.0.
		choices at: each put: v + p ].

	^ choices asSearchTree