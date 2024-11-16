tests
testGrassModelWolfram

	| tree values pair w |
	w := WolframEngine link.

	tree := [
	        | rain sprinkler grassIsWet |
	        rain := true bernoulli: w _r.
	        sprinkler := true bernoulli: w _s.
	        grassIsWet := (true bernoulli: w _g) & rain or: [
		                      (true bernoulli: w _f) & sprinkler or: [
			                      true bernoulli: w _u ] ].
	        grassIsWet when: [ rain ] ] hansei.

	pair := tree inferenceExact asValuesDictionary.
	values := pair first.

	self
		assert: (values at: true) simplify value asMathematicaPrintString
		equals:
			'Times[r, Plus[Times[g, Plus[-1, Times[f, s]], Plus[-1, u]], u, Times[f, Plus[s, Times[-1, s, u]]]]]';
		assert: (values at: false) simplify value asMathematicaPrintString
		equals:
			'Times[Plus[-1, r], Plus[Times[f, s, Plus[-1, u]], Times[-1, u]]]';
		assert: pair second size equals: 0