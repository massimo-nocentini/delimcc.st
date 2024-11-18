tests
testGrassModelWolfram

	| tree values pair w r s g f u |
	w := WolframEngine link.

	"Some symbols:"
	r := w symbol: #r.
	s := w symbol: #s.
	g := w symbol: #g.
	f := w symbol: #f.
	u := w symbol: #u.

	tree := [
	        | rain sprinkler grassIsWet |
	        rain := true bernoulli: r.
	        sprinkler := true bernoulli: s.
	        grassIsWet := (true bernoulli: g) & rain or: [
		                      (true bernoulli: f) & sprinkler or: [
			                      true bernoulli: u ] ].
	        grassIsWet when: [ rain ] ] hansei.

	pair := tree inferenceExact asValuesDictionary.
	values := pair first.

	self
		assert: ((values at: true) simplify
				 inspect;
				 asMathematicaPrintString)
		equals:
		'Times[r, Plus[Times[g, Plus[-1, Times[f, s]], Plus[-1, u]], u, Times[f, Plus[s, Times[-1, s, u]]]]]';
		assert: (values at: false) simplify asMathematicaPrintString
		equals:
		'Times[Plus[-1, r], Plus[Times[f, s, Plus[-1, u]], Times[-1, u]]]';
		assert: pair second size equals: 0