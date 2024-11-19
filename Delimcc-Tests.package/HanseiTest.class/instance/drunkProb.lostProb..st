tests
drunkProb: dp lostProb: lp

	| lost |
	lost := true bernoulli: lp.

	^ lost not when: [ true bernoulli: dp ]