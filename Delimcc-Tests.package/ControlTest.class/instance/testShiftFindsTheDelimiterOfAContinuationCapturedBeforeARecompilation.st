tests
testShiftFindsTheDelimiterOfAContinuationCapturedBeforeARecompilation
	"A captured delimiter keeps the DelimccPrompt>>#delimit: compiled when it was captured. A copy of that method stands for it here, as if #delimit: had been recompiled since."

	| k context |
	k := [ 1 + [ :kk | kk ] shift + [ :kk | 100 ] shift ] reset.
	context := k instVarNamed: #from.
	[ context selector == #delimit: ] whileFalse: [ context := context sender ].
	context instVarNamed: #method put: context method copy.
	self assert: (k value: 2) equals: 100.
	self assert: [ 1000 + (k value: 2) ] reset equals: 1100