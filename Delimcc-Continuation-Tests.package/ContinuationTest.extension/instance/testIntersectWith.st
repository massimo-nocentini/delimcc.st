*Delimcc-Continuation-Tests-tests
testIntersectWith

	| result |
	self
		assert:
			(self
				 intersect: (LinkedList with: #apple with: #banana with: #avocado)
				 withCollection: (LinkedList with: 1 with: 2 with: #apple))
		equals: (LinkedList with: #apple).
	self
		assert:
		(self intersect: ((1 to: 10) as: LinkedList) withCollection: (9 to: 20))
		equals: (9 to: 10).
	self
		assert:
		(self intersect: ((1 to: 10) as: LinkedList) withCollection: (11 to: 20))
		equals: {  }.
	"with a continuation: an empty collection escapes through it, any other one is intersected"
	result := self callcc: [ :hop |
		          self
			          intersect: ((1 to: 10) as: LinkedList)
			          withCollection: #(  )
			          continuation: hop.
		          #notEscaped ].
	self assert: result equals: #(  ).
	result := self callcc: [ :hop |
		          self
			          intersect: ((1 to: 10) as: LinkedList)
			          withCollection: (9 to: 20)
			          continuation: hop ].
	self assert: result equals: (9 to: 10).
	self assert: result lastLink value equals: 10