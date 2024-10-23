tests
testEither

	self
		assert: [
			self delimccEither: {
					1.
					(2 + 2).
					3 } ] reset asArray
		equals: #( 1 4 3 )