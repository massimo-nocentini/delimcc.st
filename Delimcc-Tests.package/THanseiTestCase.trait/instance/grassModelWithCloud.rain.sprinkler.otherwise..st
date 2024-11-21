model - wet grass
grassModelWithCloud: c rain: r sprinkler: s otherwise: u

	| cloud rain sprinkler grassIsWet |
	cloud := true bernoulli: c.
	cloud
		ifTrue: [
			rain := true bernoulli: r.
			sprinkler := true bernoulli: s ]
		ifFalse: [
			rain := true bernoulli: 1 - r.
			sprinkler := true bernoulli: 1 - s ].

	grassIsWet := rain or: [ sprinkler or: [ true bernoulli: u ] ].

	^ grassIsWet when: [ rain ]