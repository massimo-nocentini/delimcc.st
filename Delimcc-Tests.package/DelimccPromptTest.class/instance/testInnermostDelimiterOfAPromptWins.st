tests - basics
testInnermostDelimiterOfAPromptWins

	self
		assert: 1 + (p delimit: [ 1000 + (p delimit: [ 10 + (p withSubCont: [ :k | 0 ]) ]) ])
		equals: 1001