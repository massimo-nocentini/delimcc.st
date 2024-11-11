tests
drunkCoin

	| lost |
	lost := true bernoulli: 0.9.

	^ lost not when: [ true bernoulli: 0.5 ]