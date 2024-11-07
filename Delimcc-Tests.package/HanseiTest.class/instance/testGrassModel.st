tests
testGrassModel

	| tree |
	tree := [
	        | rain sprinkler grassIsWet |
	        rain := true bernoulli: 0.3.
	        sprinkler := true bernoulli: 0.5.
	        grassIsWet := (true bernoulli: 0.9) & rain or: [
		                      (true bernoulli: 0.8) & sprinkler or: [
			                      true bernoulli: 0.1 ] ].
	        grassIsWet when: [ rain ] ] hansei inferenceExact.

	self assert: tree children asLinkedList asSet equals: Set new