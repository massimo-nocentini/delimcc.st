tests
testCallCCReturnsOnTheOriginalStack
	"The code after callcc keeps running in its own contexts, so the non-local returns of detect: still find their home."

	self assert: [ | here | here := thisContext. [ :k | 1 ] callcc. thisContext == here ] reset.
	self assert: [ #(1 2 3) detect: [ :x | ([ :k | x ] callcc) = 2 ] ] reset equals: 2.
	self assert: [ #(1 2 3) detect: [ :x | ([ :k | k value: x. 0 ] callcc) = 2 ] ] reset equals: 2