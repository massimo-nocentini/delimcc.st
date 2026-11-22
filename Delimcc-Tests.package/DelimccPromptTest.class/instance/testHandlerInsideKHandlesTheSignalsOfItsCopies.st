tests - exceptions
testHandlerInsideKHandlesTheSignalsOfItsCopies

	self
		assert: (p delimit: [
				 [
				 (p shift: [ :k | (k value: 0) + (k value: 1) ]) = 0
					 ifTrue: [ 1 / 0 ]
					 ifFalse: [ 10 ] ]
					 on: ZeroDivide
					 do: [ :e | 100 ] ])
		equals: 110