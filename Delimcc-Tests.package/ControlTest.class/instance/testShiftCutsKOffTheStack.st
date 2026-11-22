testing
testShiftCutsKOffTheStack
	"The bottom context of k is the delimiter, and it has no sender: k does not hold the stack below the reset."

	| k bottom |
	k := [ 1 + [ :kk | kk ] shift ] reset.
	bottom := k instVarNamed: #from.
	[ bottom sender isNil ] whileFalse: [ bottom := bottom sender ].
	self assert: bottom selector equals: #delimit:.
	self assert: bottom receiver identicalTo: DelimccPrompt reset.
	self assert: k prompt identicalTo: DelimccPrompt reset.
	self assert: (k value: 2) equals: 3