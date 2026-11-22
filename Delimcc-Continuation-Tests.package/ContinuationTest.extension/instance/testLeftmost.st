*Delimcc-Continuation-Tests-tests
testLeftmost

	| tree visited |
	tree := #a ~~> nil ~~> nil
	        ~~> (4 ~~> (Link new ~~> (1 ~~> nil ~~> nil))).
	self
		assert: (self printStringOfTree: tree)
		equals: '(((#a)) 4 () (1))'.
	self assert: (self leftmost: #isSymbol tree: tree) equals: #a.
	self assert: (self leftmost: #isInteger tree: tree) equals: 4.
	self assert: (self leftmost: [ :v | v = 1 ] tree: tree) equals: 1.
	self assert: (self leftmost: #isNil tree: tree) equals: nil.
	self assert: (self leftmost: [ :v | v = 5 ] tree: tree) equals: nil.
	"the walk stops at the first atom that satisfies the block"
	visited := OrderedCollection new.
	self
		assert: (self
				 leftmost: [ :v |
					 visited add: v.
					 v isInteger ]
				 tree: tree)
		equals: 4.
	self assert: visited asArray equals: #( #a 4 )