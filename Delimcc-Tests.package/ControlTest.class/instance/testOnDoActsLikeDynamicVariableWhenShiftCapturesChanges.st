testing - exceptions
testOnDoActsLikeDynamicVariableWhenShiftCapturesChanges
	"The shift captures the setting to 2, so the code that k runs sees it, even when k runs outside of every handler."
	| cc |
	[[[[:k | cc := k. k value: 1] shift.
		DelimDynVarTestNotification signal ifNil: [3]]
			on: DelimDynVarTestNotification do: [:e | e resume: 2]] reset]
				on: DelimDynVarTestNotification do: [:e | e resume: 1].
	self assert: 2 equals: (cc value: 1).
	self assert: 3 equals: (DelimDynVarTestNotification signal ifNil: [3])