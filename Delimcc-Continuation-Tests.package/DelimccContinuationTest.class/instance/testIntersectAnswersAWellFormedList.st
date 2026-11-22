tests - fixes
testIntersectAnswersAWellFormedList

	| helper list |
	helper := ContinuationTest new.
	list := helper
		        intersect: ((1 to: 10) as: LinkedList)
		        withCollection: (8 to: 20).
	self assert: list asArray equals: #( 8 9 10 ).
	self assert: list lastLink value equals: 10.
	list add: 11.
	self assert: list asArray equals: #( 8 9 10 11 ).
	self assert: (helper
			 intersect: (LinkedList withAll: #( 1 2 ))
			 withCollection: #( 3 )) isEmpty