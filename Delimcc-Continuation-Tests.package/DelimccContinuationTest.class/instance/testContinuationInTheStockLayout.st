tests - snapshots
testContinuationInTheStockLayout
	"A continuation captured before Delimcc-Continuation was loaded keeps the stock layout of values. #hasSnapshots tells it apart, #capturedContexts decodes it and #restoreValues restores it as the stock method did, so it escapes, unwinding the frames it abandons, and it re-enters."

	| r chain context |
	log := OrderedCollection new.
	k := self stockContinuationFrom: thisContext.
	self deny: k hasSnapshots.
	self assert: (Continuation fromContext: thisContext) hasSnapshots.
	chain := OrderedCollection new.
	context := thisContext.
	[ context isNil ] whileFalse: [
		chain add: context.
		context := context sender ].
	self assert: k capturedContexts asArray equals: chain asArray.
	r := self stockEscape.
	self assert: r equals: 42.
	self assert: log asArray equals: #( #ensure ).
	self assert: self stockRollbackFrameTemp equals: 1.
	self assert: shots equals: 3