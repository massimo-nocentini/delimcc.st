tests - exceptions
testGenericHandlersDoNotSeeTheDelimiter

	self
		assert: (p delimit: [ [ 1 + (p shift: [ :k | k value: 1 ]) ] on: Exception do: [ :e | e return: #caught ] ])
		equals: 2.
	self
		assert: (p delimit: [ [ 1 + (p withSubCont: [ :k | k value: 1 ]) ] on: Notification do: [ :e | e resume: 5 ] ])
		equals: 2