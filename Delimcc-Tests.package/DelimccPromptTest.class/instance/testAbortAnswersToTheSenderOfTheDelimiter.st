tests - derived
testAbortAnswersToTheSenderOfTheDelimiter

	self assert: 1 + (p delimit: [ 10 + (p abort: 5) ]) equals: 6.
	self assert: (p delimit: [ [ p abort: 1 ] ensure: [ log add: #ensure ] ]) equals: 1.
	self assert: log isEmpty description: 'An abort runs no unwind block'