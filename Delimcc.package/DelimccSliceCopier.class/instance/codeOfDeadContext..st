codes
codeOfDeadContext: aContext
	"R9: copy aContext, which is not one of my contexts, when its closure has a copy: then it is the context of a block whose home is one of them, and has returned. A closure made by that block keeps it as its outer context, and a ^ in that closure finds its home through the closure of aContext, so the copy of the closure needs a copy of aContext whose closure (instance variable 5) is re-pointed. The outer contexts are walked first, down to the home, as scanning their closures and reading whether a context of the stack has returned are slow."

	| context closure code |
	context := aContext.
	[
	(closure := context closure) == nil ifTrue: [ ^ 0 ].
	(context := closure outerContext) == nil ifTrue: [ ^ 0 ].
	(self indexOfFrame: context) = 0 ] whileTrue.
	originals == nil ifFalse: [ (self codeOf: aContext) ifNotNil: [ :known | ^ known ] ].
	closure := aContext closure sliceCodeDelimcc: self.
	(closure = 0 or: [ aContext isDead not ]) ifTrue: [ ^ 0 ].
	code := self register: aContext.
	self patch: 5 of: code to: closure.
	^ code