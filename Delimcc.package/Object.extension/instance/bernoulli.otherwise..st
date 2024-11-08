*Delimcc
bernoulli: p otherwise: other

	^ Dictionary new
		  at: self put: p;
		  at: other put: 1.0 - p;
		  asSearchTreeShift