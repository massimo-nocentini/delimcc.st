tests - review 1
testNonLocalReturnFromEachShot

	self assert: (self isolated: [ [ self returnOfTwoShots + 1 ] reset ]) equals: 32