tests - fixes
testNeverCapturedSignalsError
	"A stock value: cut the stack before restoreValues sent readStream to the nil values, so no handler could catch the error. The message tells that the guard, not a later failure on the nil values, signalled it."

	| caught |
	log := OrderedCollection new.
	caught := [
	          Continuation new value: 1.
	          log add: #afterValue ]
		          on: Error
		          do: [ :e | e return: e messageText ].
	self assert: caught equals: 'This continuation was never captured'.
	self assert: log isEmpty