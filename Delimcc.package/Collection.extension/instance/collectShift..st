*Delimcc
collectShift: aBlock

	^ [ :k | self collect: [ :each | k value: (aBlock value: each) ] ]
		  shift