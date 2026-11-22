tests - machine
testContinuationResumedInAnotherProcess

	| k done result |
	k := p delimit: [ 1 + (p shift: [ :kk | kk ]) ].
	done := Semaphore new.
	[
	result := k value: 41.
	done signal ] fork.
	self deny: (done waitTimeoutSeconds: 5).
	self assert: result equals: 42