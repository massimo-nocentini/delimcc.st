tests - review 2
testShiftInsideAHandler
	"q.st of the review: each invocation returns through its own copy of the exception to its own copy of the on:do: context."

	self
		assert: (self isolated: [
				 [ [ ([ 1 / 0 ] on: ZeroDivide do: [ :e | [ :k | (k value: 1) + (k value: 2) ] shift ]) * 10 ] reset ]
					 on: Error
					 do: [ :e | #caught ] ])
		equals: 30.
	self assert: (self isolated: [ [ ([ 1 / 0 ] on: ZeroDivide do: [ :e | [ :k | k value: 3 ] shift ]) * 10 ] reset ]) equals: 30