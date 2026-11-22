tests - structure
testProcesses
	"Invocations in other processes (#isolated: runs each one in a process of its own), a capture in another process, and four processes that interleave their invocations."

	| k done results |
	k := [ self returnOfK + 1 ] reset.
	self assert: ((1 to: 2) collect: [ :i | self isolated: [ k value: i ] ]) equals: #( 2 3 ).
	self assert: (k value: 3) equals: 4.
	done := Semaphore new.
	[
	k := [ self returnOfK + 1 ] reset.
	done signal ] fork.
	done wait.
	self assert: (self isolated: [ { (k value: 10). (k value: 20) } ]) equals: #( 11 21 ).
	k := [ self returnOfK + 1 ] reset.
	results := OrderedCollection new.
	1 to: 4 do: [ :i |
		[
		1 to: 50 do: [ :j |
			results add: (k value: j).
			Processor yield ].
		done signal ] fork ].
	4 timesRepeat: [ done wait ].
	self assert: results size equals: 200.
	self assert: (results inject: 0 into: [ :a :b | a + b ]) equals: 5300