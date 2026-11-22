tests - fixes
testNeverCapturedSignalsError
	"A stock value: cut the stack before restoreValues sent readStream to the nil values, so no handler could catch the error."

	| caught |
	log := OrderedCollection new.
	caught := [
	          Continuation new value: 1.
	          log add: #afterValue ]
		          on: Error
		          do: [ :e | e return: #caught ].
	self assert: caught equals: #caught.
	self assert: log isEmpty