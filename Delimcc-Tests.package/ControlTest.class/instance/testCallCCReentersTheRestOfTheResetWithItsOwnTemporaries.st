tests
testCallCCReentersTheRestOfTheResetWithItsOwnTemporaries
	"kc is assigned by the block of callcc, so the compiler keeps it in a temp vector of the reset block: the copies of k share it with the original contexts, and see it."

	| log |
	log := OrderedCollection new.
	self
		assert: [
			| m kc |
			m := [ :k |
			     kc := k.
			     0 ] callcc.
			log add: m.
			m < 3 ifTrue: [ kc value: m + 1 ].
			m ] reset
		equals: 3.
	self assert: log asArray equals: #( 0 1 2 3 )