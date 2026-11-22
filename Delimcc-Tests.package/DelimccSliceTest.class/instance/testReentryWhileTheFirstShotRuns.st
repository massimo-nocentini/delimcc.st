tests - temps
testReentryWhileTheFirstShotRuns

	self
		assert: [
			| v |
			v := [ :k |
			     held := k.
			     k value: 1 ] shift.
			v < 3
				ifTrue: [ held value: v + 1 ]
				ifFalse: [ v ] ] reset
		equals: 3