tests
testExplorationCanBeResumedTwice
	"A continuation that captures the rest of an exploration can be resumed more than once: each resumption adds up only its own answers."

	| ks first second |
	ks := [
	      [
	      (true bernoulli: 1 / 2)
		      ifTrue: [ #t ]
		      ifFalse: [ [ :k1 | [ :k2 | { k1. k2 } ] shift ] shift ] ] hansei
		      inferenceExact ] reset.

	first := ks second value: (ks first value: 1).
	second := ks second value: (ks first value: 2).

	self
		assert: first asValuesDictionary first
		equals: (Dictionary newFrom: { #t -> (1 / 2). 1 -> (1 / 2) });
		assert: second asValuesDictionary first
		equals: (Dictionary newFrom: { #t -> (1 / 2). 2 -> (1 / 2) })