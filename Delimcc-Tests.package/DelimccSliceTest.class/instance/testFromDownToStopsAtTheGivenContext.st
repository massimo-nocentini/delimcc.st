tests - structure
testFromDownToStopsAtTheGivenContext
	"An operator written with the legacy constructor #from:downTo: gets a continuation of the contexts down to the given one, not of the whole stack below it (review-semantics 5)."

	self
		assert: (self isolated: [ 100 + [ 10 + (self legacyShift: [ :k | (k value: 1) + (k value: 2) ]) ] reset ])
		equals: 123.
	self
		assert: (self isolated: [ 100 + ([ 10 + (self legacyShift: [ :k | k ]) ] reset value: 5) ])
		equals: 115