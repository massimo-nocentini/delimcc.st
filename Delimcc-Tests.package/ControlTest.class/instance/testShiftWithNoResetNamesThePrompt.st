testing - exceptions
testShiftWithNoResetNamesThePrompt

	| error |
	error := [ [ :k | 1 + 2 ] shift ] on: MissingResetException do: [ :e | e ].
	self assert: error prompt identicalTo: DelimccPrompt reset.
	self assert: error messageText equals: 'no delimiter of a DelimccPrompt(reset) on the stack'