tests - derived
testChooseSolvesQueens

	self assert: (self queens: 4) size equals: 2.
	self assert: (self queens: 6) size equals: 4.
	self assert: (self queens: 8) size equals: 92