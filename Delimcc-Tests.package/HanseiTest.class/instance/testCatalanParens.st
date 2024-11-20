tests
testCatalanParens

	| tree avg pair e p tot |
	e := 0.01.
	p := 0.5.

	tree := [ self catalanParens: e pickProb: p ] hansei.
	avg := (tree inferenceUpToDepth: 40) average.

	self assert: avg size equals: 40959