tests
testSimpleShift1

	| block |
	block := [ :x | 2 + x ]. "mimic the captured delimited continuation."

	self
		assert: [ 2 + [ :k | 100 + (k ! 3) ] shift ] reset + 10
		equals: 100 + (block ! 3) + 10