*Delimcc
bernoulli: prob otherwise: other

	| p |
	"p := prob min: 1.0 max: 0.0."
	^ Dictionary new
		  at: self put: prob;
		  at: other put: 1 - prob;
		  chooseShift