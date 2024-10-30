tests
testShiftWithoutReset

	self
		should: [ [ :_ | 10 ] shift ] raise: MissingResetException;
		should: [ [ :_ | 1 / 0 ] shift ] raise: MissingResetException;
		should: [ [ :k | k value: 10 ] shift ] raise: MissingResetException