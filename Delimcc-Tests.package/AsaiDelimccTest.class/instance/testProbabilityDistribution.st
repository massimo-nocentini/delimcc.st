tests
testProbabilityDistribution

	| distribution |
	distribution := {
		                (true -> 0.6).
		                (false -> 0.4) } delimccDistribution: [ :v |
		                {
			                (true -> 0.2).
			                (false -> 0.8) } delimccDistribution: [ :w |
			                {
				                v.
				                w } ] ].

	(distribution exploreUpToDepth: 4) inspect