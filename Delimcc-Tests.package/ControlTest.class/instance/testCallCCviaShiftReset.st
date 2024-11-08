tests
testCallCCviaShiftReset

	self assert: [ :k | 1 + (k value: 3) ] callcc equals: 3