model - drunk
drunkCoin: n drunkProb: dp lostProb: lp

	| drunk |
	drunk := self drunkProb: dp lostProb: lp.

	^ n = 1
		  ifTrue: [ drunk ]
		  ifFalse: [
		  drunk and: [ self drunkCoin: n - 1 drunkProb: dp lostProb: lp ] ]