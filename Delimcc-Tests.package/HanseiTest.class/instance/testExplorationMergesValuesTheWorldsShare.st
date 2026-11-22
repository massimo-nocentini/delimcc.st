tests
testExplorationMergesValuesTheWorldsShare
	"The worlds of this model fill the same Array, so they all answer it in its final state: exploring merges them into one value that keeps all the mass."

	| tree |
	tree := [
	        | a |
	        a := Array new: 8.
	        1 to: 8 do: [ :i | a at: i put: (true bernoulli: 1 / 2) ].
	        a ] hansei inferenceExact.

	self
		assert: tree children size equals: 1;
		assert: tree children value weight equals: 1