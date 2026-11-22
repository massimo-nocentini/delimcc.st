tests - review 1
testSliceClosureCapturedByAReturnedMethod

	self assert: (self isolated: [ [ self returnThroughAWrapper ] reset ]) equals: 30