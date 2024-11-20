tests
testCatalanParens

	| tree avg e p |
	e := 0.01.
	p := 0.5.

	tree := [ self catalanParens: e pickProb: p ] hansei.
	avg := (tree inferenceUpToDepth: 40) average.
	"	avg associations timsort: [ :each | each key size ]."
	self assert: avg size equals: 8192.
	self assert: (avg at: '') closeTo: 0.009999999999999641.
	self assert: (avg at: '()') closeTo: 0.009899999999999645