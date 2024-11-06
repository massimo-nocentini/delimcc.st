tests
testAmbAmb

	| res |
	res := [
	       | v w |
	       v := self amb: #( 1 2 ).
	       w := self amb: #( 4 5 ).
	       v + 3 + w ] reset.

	self assert: res equals: #( 8 9 9 10 )