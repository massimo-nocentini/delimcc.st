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
		assert: (values at: true) simplify asString
		equals: 'r (g (-1 + f s) (-1 + u) + u + f (s - s u))'.

	self
		assert: (values at: false) simplify asString
		equals: '(-1 + r) (f s (-1 + u) - u)'.

	self assert: pair second size equals: 0