tests
testAmbWwwWwwWww

	| res |
	res := [
	       | p v u |
	       p := self amb: #( 0 2 3 4 5 32 ).
	       v := self www: p.
	       u := self www: v.
	       self www: u ] reset.

	self assert: res size equals: 48000