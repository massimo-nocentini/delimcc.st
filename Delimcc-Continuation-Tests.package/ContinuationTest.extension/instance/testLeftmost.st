*Delimcc-Continuation-Tests-tests
testLeftmost

	| tree withNil visited |
	tree := #a ~~> nil ~~> nil
	        ~~> (4 ~~> (Link new ~~> (1 ~~> nil ~~> nil))).
	self
		assert: (self printStringOfTree: tree)
		equals: '(((#a)) 4 () (1))'.
	self assert: (self leftmost: #isSymbol tree: tree) equals: #a.
	self assert: (self leftmost: #isInteger tree: tree) equals: 4.
	self assert: (self leftmost: [ :v | v = 1 ] tree: tree) equals: 1.
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
	self assert: visited asArray equals: #( #a 4 ).
	"nil is an atom too. Both walks below answer nil: the first one stops at the nil atom, the second one visits every atom of a tree that has none"
	withNil := 4 ~~> (nil ~~> (1 ~~> nil)).
	self assert: (self printStringOfTree: withNil) equals: '(4 nil 1)'.
	visited := OrderedCollection new.
	self
		assert: (self
				 leftmost: [ :v |
					 visited add: v.
					 v isNil ]
				 tree: withNil)
		equals: nil.
	self assert: visited asArray equals: #( 4 nil ).
	visited := OrderedCollection new.
	self
		assert: (self
				 leftmost: [ :v |
					 visited add: v.
					 v isNil ]
				 tree: tree)
		equals: nil.
	self assert: visited asArray equals: #( #a 4 1 )
