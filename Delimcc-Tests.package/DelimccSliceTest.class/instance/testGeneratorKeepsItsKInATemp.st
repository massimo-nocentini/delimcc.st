tests - temps
testGeneratorKeepsItsKInATemp
	"kk is in a temp vector of the slice, assigned before the first invocation, so the template has it."

	self
		assert: [
			| v kk |
			v := [ :k | kk := k. k value: 1 ] shift.
			log add: v.
			v < 3 ifTrue: [ kk value: v + 1 ].
			v ] reset
		equals: 1.
	self assert: log asArray equals: #( 1 2 3 )