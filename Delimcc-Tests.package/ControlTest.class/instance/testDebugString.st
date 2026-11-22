testing
testDebugString
	| cc s |
	[ 1 + [ :k | cc := k. k value: 2 ] shift ] reset.
	s := cc debugString.
	self assert: (s includesSubstring: 'testDebugString').
	self assert: (s includesSubstring: (DelimccPrompt >> #delimit:) sourceCode).
	self assert: (s lines count: [ :each | each = '=======' ]) equals: cc stack size