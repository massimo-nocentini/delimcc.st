tests - exceptions
testHandlerOutsideTheDelimiterSeesTheErrorsOfK

	| k |
	self assert: ([ p delimit: [ 1 + (p shift: [ :kk | 1 / 0 ]) ] ] on: ZeroDivide do: [ :e | -1 ]) equals: -1.
	k := p delimit: [ (p shift: [ :kk | kk ]) / 0 ].
	self assert: ([ k value: 1 ] on: ZeroDivide do: [ :e | #outer ]) equals: #outer