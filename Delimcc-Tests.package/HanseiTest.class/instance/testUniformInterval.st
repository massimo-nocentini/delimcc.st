tests
testUniformInterval

	| tree values pair |
	tree := [ (1 to: 20) asSearchTreeShift ] hansei.

	pair := tree inferenceExact asValuesDictionary.
	values := pair first.

	1 to: 20 do: [ :i | self assert: (values at: i) equals: 0.05 ].

	self assert: pair second size equals: 0