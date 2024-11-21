model - wet grass
grassModelWithCloud: c rain: r sprinkler: s otherwise: u

	| cloud rain sprinkler grassIsWet |
	cloud := true bernoulli: c.
	rain := true bernoulli: r.
	sprinkler := true bernoulli: s.
	grassIsWet := rain or: [ sprinkler or: [ true bernoulli: u ] ].
	^ grassIsWet when: [ rain ]