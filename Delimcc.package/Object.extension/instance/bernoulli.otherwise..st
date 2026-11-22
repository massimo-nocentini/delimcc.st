*Delimcc
bernoulli: prob otherwise: other

	| weights |
	weights := Dictionary new.
	weights at: self put: prob.
	weights at: other put: (weights at: other ifAbsent: 0) + (1 - prob).

	^ weights chooseShift