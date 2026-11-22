tests - fixes
testYieldingThroughValueWithoutUnwindingKeepsTheEnsureBlockBalanced
	"A generator that yields with valueWithoutUnwinding: from inside an ensure: runs the ensure: block once, at its end, as with the stock value:. Inside a critical: section, the lock stays taken from the first value to the end, so another process gets in only after the generator is done, and the semaphore ends as it started."

	| semaphore mutex entered enteredWhileInside |
	log := OrderedCollection new.
	self
		assert: (self
				 generatorValues: [ :body |
					 [
					 log add: #open.
					 body value ] ensure: [ log add: #close ] ]
				 jump: #valueWithoutUnwinding:
				 do: [ :each | ])
		equals: #( 1 2 3 #done ).
	self assert: log asArray equals: #( #open #close ).
	semaphore := Semaphore forMutualExclusion.
	self
		assert: (self
				 generatorValues: [ :body | semaphore critical: body ]
				 jump: #valueWithoutUnwinding:
				 do: [ :each | ])
		equals: #( 1 2 3 #done ).
	self assert: (semaphore instVarNamed: #excessSignals) equals: 1.
	mutex := Mutex new.
	entered := false.
	self
		assert: (self
				 generatorValues: [ :body | mutex critical: body ]
				 jump: #valueWithoutUnwinding:
				 do: [ :each |
					 each = 1 ifTrue: [
						 [ mutex critical: [ entered := true ] ] forkAt:
							 Processor activePriority + 1.
						 enteredWhileInside := entered ] ])
		equals: #( 1 2 3 #done ).
	self deny: enteredWhileInside.
	self assert: entered