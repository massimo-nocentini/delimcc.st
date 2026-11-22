tests
testCallCCReentersTheRestOfTheReset
	"k is the rest of the computation up to the reset: invoking it runs the code after callcc again."
	| kc log |
	log := OrderedCollection new.
	self
		assert: [ | m |
			m := [ :k | kc := k. 0 ] callcc.
			log add: m.
			m < 3 ifTrue: [ kc value: m + 1 ].
			m ] reset
		equals: 3.
	self assert: #(0 1 2 3) equals: log asArray