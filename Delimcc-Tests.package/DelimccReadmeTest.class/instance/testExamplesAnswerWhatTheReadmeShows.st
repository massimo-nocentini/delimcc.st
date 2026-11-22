tests
testExamplesAnswerWhatTheReadmeShows

	self examples do: [ :each |
		self
			assert: (self class compiler evaluate: each) printString
			equals: (self answerOf: each) ]