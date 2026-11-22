tests - ensure
testEnsureOfShotsAfterTheReset

	| k |
	k := [ [ [ :kk | kk ] shift ] ensure: [ log add: #ensure ] ] reset.
	self assert: log isEmpty.
	self
		assert: {
				(k value: 5).
				(k value: 7).
				log asArray }
		equals: #( 5 7 #( #ensure #ensure ) )