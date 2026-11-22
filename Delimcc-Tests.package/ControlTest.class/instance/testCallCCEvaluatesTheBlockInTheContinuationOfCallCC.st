tests
testCallCCEvaluatesTheBlockInTheContinuationOfCallCC
	"A shift inside the block captures the code after callcc, as with Scheme48's cwcc: s is 10 + [], not the block alone."

	self
		assert: [ 10 + ([ :k | [ :s | (s value: 1) + (s value: 2) ] shift ] callcc) ] reset
		equals: 23