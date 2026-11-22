tests - tags
testGeneratorsOnTwoPromptsCompareFringes

	self assert: (self sameFringe: #( 1 #( 2 3 ) #( #( 4 ) ) ) and: #( #( 1 2 ) 3 4 )).
	self deny: (self sameFringe: #( 1 2 ) and: #( 1 2 3 )).
	log removeAll.
	self deny: (self sameFringe: #( 1 #( 2 3 ) #( #( 4 ) ) 5 6 ) and: #( #( 1 2 ) 9 4 5 6 )).
	"Both walks stop at the first leaves that differ."
	self assert: log asArray equals: #( 1 1 2 2 3 9 )