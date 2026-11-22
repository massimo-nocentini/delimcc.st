*Delimcc-Continuation-evaluating
value: anObject
	"Invoke the continuation and answer anObject as return value.

	Nothing changes when I cannot be invoked: a continuation that was never captured, or one whose stack another live process is running (see #anotherLiveProcessRunning:), signals an Error that a handler around me can catch. I signal both Errors myself, with ^, so if a handler resumes one of them (as the debugger's Proceed does), I answer what it resumed with and the current stack goes on as if I had not been invoked.

	Otherwise the invocation abandons every frame of the current stack that is not one of mine, above the longest bottom part that the current stack and mine have in common (the whole current stack when they have none). Those frames are unwound as Exception>>#return: unwinds the frames above its handler: their ensure: and ifCurtailed: blocks run once, from the top down, and the frames are terminated. A frame below one that both stacks share is abandoned too when a sender link was rewired after I was captured, as Generator>>#next does. Then my frames get back the state they had when I was captured, and anObject is answered to the frame that captured me."

	| captured mine process current context index capturedIndex unwindBlock |
	values ifNil: [ ^ self error: 'This continuation was never captured' ].
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
			(context isUnwindContext and: [ context unwindComplete isNil ])
				ifTrue: [
					context unwindComplete: true.
					unwindBlock := context unwindBlock.
					thisContext swapSender: context.
					unwindBlock value ].
			context terminate ] ].
	self restoreValues.
	thisContext swapSender: values first.
	^ anObject