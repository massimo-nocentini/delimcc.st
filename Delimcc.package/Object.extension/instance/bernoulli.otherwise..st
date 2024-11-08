*Delimcc
bernoulli: prob otherwise: other

	| p |
	p := prob min: 1 max: 0.

	^ Dictionary new
		  at: self put: p;
		  at: other put: 1.0 - p;
		  asSearchTreeShift