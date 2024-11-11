tests
drunkCoin: n

	^ n = 1
		  ifTrue: [ self drunkCoin ]
		  ifFalse: [ self drunkCoin and: [ self drunkCoin: n - 1 ] ]