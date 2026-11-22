tests - fixes
testRemoveUptoLastAnswersAWellFormedList
	"A stock ContinuationTest>>#remove:uptoLast: answered LinkedList with: the remaining chain: a LinkedList of nil when nothing remained, and otherwise a list whose last link was its first one."

	| helper list |
	helper := ContinuationTest new.
	list := helper remove: #x uptoLast: (LinkedList withAll: #( #a #b #x )).
	self assert: list isEmpty.
	list := helper
		        remove: #x
		        uptoLast: (LinkedList withAll: #( #a #x #b #c )).
	self assert: list asArray equals: #( #b #c ).
	self assert: list lastLink value equals: #c.
	list add: #z.
	self assert: list asArray equals: #( #b #c #z )