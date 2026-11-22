*Delimcc-Continuation-Tests-tests
testTwoInARow

	| tree1 tree2 |
	tree1 := #solid ~~> (#food ~~> nil ~~> (Link new ~~> nil))
	         ~~> (#food ~~> nil ~~> nil ~~> nil ~~> nil).
	tree2 := #solid ~~> (#food ~~> nil ~~> (#marmellade ~~> nil))
	         ~~> (#food ~~> nil ~~> nil ~~> nil ~~> nil).
	self
		assert: (self printStringOfTree: tree1)
		equals: '((#solid (#food) ()) (((#food))))'.
	self assert: (TwoInARowStar new tree: tree1) equals: true.
	self
		assert: (self printStringOfTree: tree2)
		equals: '((#solid (#food) #marmellade) (((#food))))'.
	self assert: (TwoInARowStar new tree: tree2) equals: false.
	"atoms are not only symbols"
	self assert: (TwoInARowStar new tree: 1 ~~> (1 ~~> nil)) equals: true.
	self assert: (TwoInARowStar new tree: 1 ~~> (2 ~~> nil)) equals: false.
	self
		assert: (TwoInARowStar new tree: 1 ~~> (#a ~~> (#a ~~> nil)))
		equals: true