tests - fixes
testYieldingThroughValueRunsTheEnsureBlockAtEachYield
	"A change from stock that follows from the unwinding escape: a generator that yields with value: from inside an ensure: runs the ensure: block at each yield, since the yield abandons the frame, and once more at its end, while each re-entry restores the frame without running the code before the ensure: again. Inside a critical: section, each yield releases the lock, so another process gets in while the generator is still inside, and the semaphore ends with one signal per yield too many. Stock value: ran no unwind block, so these patterns were balanced; #valueWithoutUnwinding: keeps them so (see #testYieldingThroughValueWithoutUnwindingKeepsTheEnsureBlockBalanced)."

	| semaphore mutex entered enteredWhileInside |
	log := OrderedCollection new.
	self
		assert: (self
				 generatorValues: [ :body |
					 [
					 log add: #open.
					 body value ] ensure: [ log add: #close ] ]
				 jump: #value:
				 do: [ :each | ])
		equals: #( 1 2 3 #done ).
	self assert: log asArray equals: #( #open #close #close #close #close ).
	semaphore := Semaphore forMutualExclusion.
	self
		assert: (self
				 generatorValues: [ :body | semaphore critical: body ]
				 jump: #value:
				 do: [ :each | ])
		equals: #( 1 2 3 #done ).
	self assert: (semaphore instVarNamed: #excessSignals) equals: 4.
	mutex := Mutex new.
	entered := false.
	self
		assert: (self
				 generatorValues: [ :body | mutex critical: body ]
				 jump: #value:
				 do: [ :each |
					 each = 1 ifTrue: [
						 [ mutex critical: [ entered := true ] ] forkAt:
							 Processor activePriority + 1.
						 enteredWhileInside := entered ] ])
		equals: #( 1 2 3 #done ).
	self assert: enteredWhileInside