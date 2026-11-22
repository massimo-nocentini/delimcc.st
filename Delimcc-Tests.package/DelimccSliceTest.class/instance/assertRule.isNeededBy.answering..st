helpers
assertRule: aRule isNeededBy: aSelector answering: anObject
	"The probe aSelector answers anObject with the copies of DelimccSliceCopier, and something else without aRule."

	self assert: (self isolated: [ self perform: aSelector with: DelimccSliceCopier new ]) equals: anObject.
	self deny: (self isolated: [ self perform: aSelector with: (DelimccAblatedSliceCopier without: aRule) ]) equals: anObject