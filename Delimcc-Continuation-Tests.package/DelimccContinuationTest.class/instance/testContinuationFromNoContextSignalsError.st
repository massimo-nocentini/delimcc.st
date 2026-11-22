tests - fixes
testContinuationFromNoContextSignalsError
	"Continuation fromContext: nil holds no frame at all, so it cannot be invoked any more than one that was never captured: it signals the same Error before it changes anything. Without the check, the invocation abandoned the whole current stack, since it shares no frame with an empty one, and then failed on the empty values with no handler left."

	| caught |
	log := OrderedCollection new.
	caught := [
	          (Continuation fromContext: nil) value: 1.
	          log add: #afterValue ]
		          on: Error
		          do: [ :e | e return: e messageText ].
	self assert: caught equals: 'This continuation was never captured'.
	self assert: log isEmpty