tests
testUniformInterval

	| tree values pair |
	tree := [ (1 to: 20) chooseShift ] hansei.

	pair := tree inferenceExact asValuesDictionary.
	values := pair first.

	1 to: 20 do: [ :i | self assert: (values at: i) equals: 1 / 20 ].

	self assert: pair second size equals: 0