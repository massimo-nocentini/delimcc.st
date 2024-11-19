model - wet grass
grassModelPriorRain: r rain: g priorSprinkler: s sprinkler: f otherwise: u

	| rain sprinkler grassIsWet |
	rain := true bernoulli: r.
	sprinkler := true bernoulli: s.
	grassIsWet := (true bernoulli: g) & rain or: [
		              (true bernoulli: f) & sprinkler or: [
			              true bernoulli: u ] ].
	^ grassIsWet when: [ rain ]