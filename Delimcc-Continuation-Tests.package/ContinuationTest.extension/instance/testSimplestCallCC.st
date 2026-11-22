*Delimcc-Continuation-Tests-tests
testSimplestCallCC

	| x |
	x := self callcc: [ :cc |
		     cc value: true.
		     false ].
	self assert: x