tests - structure
testContinuationAndItsTemplateAreCollected

	| k weak |
	k := [ self deep: 5 ] reset.
	weak := WeakArray new: 3.
	weak at: 1 put: (k instVarNamed: #from).
	k value: 1.
	weak at: 2 put: k template frames first.
	k value: 2.
	weak at: 3 put: k.
	k := nil.
	Smalltalk garbageCollect.
	self assert: (Array withAll: weak) equals: #( nil nil nil )