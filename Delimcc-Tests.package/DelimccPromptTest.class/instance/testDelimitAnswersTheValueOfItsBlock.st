tests - basics
testDelimitAnswersTheValueOfItsBlock

	self assert: (p delimit: [ 42 ]) equals: 42.
	self deny: p isDelimiting.
	self assert: (p delimit: [ p isDelimiting ]).
	self deny: (q delimit: [ p isDelimiting ])