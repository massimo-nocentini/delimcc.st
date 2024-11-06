tests
testAmb

	| res |
	res := [ self amb: #( 1 2 3 ) ] reset.

	self assert: res equals: #( 1 2 3 )