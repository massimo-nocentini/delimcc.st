*Delimcc-Continuation-private
invokeWith: anObject unwinding: aBoolean
	"Answer anObject to the frame that captured me, as #value: describes. When aBoolean is false, the frames that the invocation abandons are terminated without running their unwind blocks, as #valueWithoutUnwinding: describes.
	Each check signals its Error with ^ from here, before anything changes, so when a handler resumes it, my sender answers what the handler resumed with.
	The current stack and mine are compared from their bottoms: the frames that both have at the bottom are shared, and only the captured frames above that part (capturedAbove) can be among the current frames above it, since a frame is only once on a stack. So the set to look frames up in holds only those, often none at all, and the walk of the current stack decides whether the stacks share a frame before any process is scanned."

	| captured capturedAbove process current context index capturedIndex unwindBlock |
	(values isNil or: [ values isEmpty ]) ifTrue: [
		^ self error: 'This continuation was never captured' ].
	captured := self capturedContexts.
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
	capturedAbove := IdentitySet new.
	1 to: capturedIndex do: [ :each | capturedAbove add: (captured at: each) ].
	(capturedIndex < captured size or: [
		 (1 to: index) anySatisfy: [ :each |
			 capturedAbove includes: (current at: each) ] ]) ifFalse: [
		process := self anotherLiveProcessRunning: capturedAbove.
		process ifNotNil: [
			^ self error:
				  'This continuation belongs to the stack of another live process: '
				  , process printString ] ].
	1 to: index do: [ :each |
		context := current at: each.
		(capturedAbove includes: context) ifFalse: [
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