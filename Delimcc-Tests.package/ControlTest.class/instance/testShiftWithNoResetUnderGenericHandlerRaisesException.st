testing - exceptions
testShiftWithNoResetUnderGenericHandlerRaisesException

	self
		should: [ [ [ :k | 1 + 2 ] shift ] on: Notification do: [ :e | e resume: 5 ] ]
		raise: MissingResetException
		description: 'A generic handler answered for the missing reset'