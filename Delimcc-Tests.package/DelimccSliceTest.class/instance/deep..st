helpers
deep: n

	^ n = 0
		  ifTrue: [ [ :k | k ] shift ]
		  ifFalse: [ 1 + (self deep: n - 1) ]