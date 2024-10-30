tests
testSimpleShift

	| block |
	block := [ :x | 2 * x ]. "mimic the captured delimited continuation."

	self
		assert: [ 2 * [ :k | k ! (k ! 10) ] shift ] reset + 1
		equals: block ! (block ! 10) + 1