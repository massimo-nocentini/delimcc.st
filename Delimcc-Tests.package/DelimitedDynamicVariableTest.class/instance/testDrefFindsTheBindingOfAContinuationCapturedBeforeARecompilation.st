testing
testDrefFindsTheBindingOfAContinuationCapturedBeforeARecompilation
	"A captured binding keeps the DelimitedDynamicVariableRef>>#during: compiled when it was captured. A copy of that method stands for it here, as if #during: had been recompiled since."

	| p k context |
	p := DelimitedDynamicVariable default: 0.
	k := [ p dlet: 1 in: [ [ :c | c ] shift. p dref ] ] reset.
	context := k instVarNamed: #from.
	[ context selector == #during: ] whileFalse: [ context := context sender ].
	context instVarNamed: #method put: context method copy.
	self assert: (k value: nil) equals: 1