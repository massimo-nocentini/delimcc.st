tests - snapshots
testSnapshotsHoldWhatTheStockCaptureReads
	"Each snapshot that Continuation>>#initializeFromContext: takes with one #shallowCopy holds the same sender, pc, stackp, method, closureOrNil, receiver and stack slots as the stock capture reads with #instVarAt: and #at:, on married frames, on frames of a stack that spans several stack pages, and after a garbage collection."

	#( 0 1 100 3000 ) do: [ :n |
		| result |
		result := self depth: n do: [ self mismatchesOfSnapshotsOf: thisContext ].
		self assert: result first > n.
		self assert: result last equals: #(  ) ].
	self
		assert: (self depth: 100 do: [
				 Smalltalk garbageCollect.
				 (self mismatchesOfSnapshotsOf: thisContext) last ])
		equals: #(  )