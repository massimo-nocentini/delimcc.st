tests - tags
testShift0InsideAHanseiModel
	"Hansei captures to the reset prompt, through the delimiter of p, which each world gets again."

	| values |
	values := [ p delimit: [ | b | b := true bernoulli: 1 / 4. p shift0: [ :k | (k value: b) not ] ] ] hansei inferenceExact asValuesDictionary first.
	self assert: (values at: true) equals: 3 / 4.
	self assert: (values at: false) equals: 1 / 4