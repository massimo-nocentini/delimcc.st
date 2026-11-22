*Delimcc-Continuation-private
invokeWith: anObject unwinding: aBoolean
	"Answer anObject to the frame that captured me, as #value: describes. When aBoolean is false, the frames that the invocation abandons are terminated without running their unwind blocks, as #valueWithoutUnwinding: describes.
	Each check signals its Error with ^ from here, before anything changes, so when a handler resumes it, my sender answers what the handler resumed with."

	| captured mine process current context index capturedIndex unwindBlock |
	(values isNil or: [ values isEmpty ]) ifTrue: [
		^ self error: 'This continuation was never captured' ].
	captured := self capturedContexts.
	mine := captured asIdentitySet.
	(thisContext findContextSuchThat: [ :each | mine includes: each ])
		ifNil: [
			process := self anotherLiveProcessRunning: mine.
			process ifNotNil: [
				^ self error:
					  'This continuation belongs to the stack of another live process: '
					  , process printString ] ].
	current := OrderedCollection new.
	context := thisContext sender.
	[ context isNil ] whileFalse: [
		current add: context.
		context := context sender ].
	index := current size.
	capturedIndex := captured size.
	[
	index > 0 and: [
		capturedIndex > 0 and: [
			(current at: index) == (captured at: capturedIndex) ] ] ]
		whileTrue: [
			index := index - 1.
			capturedIndex := capturedIndex - 1 ].
	1 to: index do: [ :each |
		context := current at: each.
		(mine includes: context) ifFalse: [
			(aBoolean and: [
				 context isUnwindContext and: [ context unwindComplete isNil ] ])
				ifTrue: [
					context unwindComplete: true.
					unwindBlock := context unwindBlock.
					thisContext swapSender: context.
					unwindBlock value ].
			context terminate ] ].
	self restoreValues.
	thisContext swapSender: values first.
	^ anObject