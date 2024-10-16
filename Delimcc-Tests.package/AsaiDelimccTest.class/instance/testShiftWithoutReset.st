tests
testShiftWithoutReset

	self should: [ [ :_ | 10 ] shift ] raise: MissingResetException