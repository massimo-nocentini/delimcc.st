*Delimcc
bernoulli: prob otherwise: other

	^ Dictionary new
		  at: self put: prob;
		  at: other put: 1 - prob;
		  chooseShift