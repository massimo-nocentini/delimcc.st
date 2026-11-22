tests - derived
testChooseFindsPythagoreanTriples

	| triples |
	triples := p delimit: [
		           | a b c |
		           a := self choose: (1 to: 10).
		           b := self choose: (a to: 10).
		           c := self choose: (b to: 10).
		           a * a + (b * b) = (c * c)
			           ifTrue: [ { { a. b. c } } ]
			           ifFalse: [ #(  ) ] ].
	self assert: triples equals: #( #( 3 4 5 ) #( 6 8 10 ) )