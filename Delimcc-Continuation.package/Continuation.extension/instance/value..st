*Delimcc-Continuation-evaluating
value: anObject
	"Invoke the continuation and answer anObject as return value.

	Nothing changes when I cannot be invoked: a continuation that was never captured, or one whose stack another live process is running (see #signalIfAnotherProcessRuns:), signals an Error that a handler around me can catch.

	Otherwise the frames that the invocation abandons, those above the topmost frame that the current stack shares with mine (all of them when it shares none), are unwound as Exception>>#return: unwinds the frames above its handler: their ensure: and ifCurtailed: blocks run once, from the top down, and the frames are terminated. Then my frames get back the state they had when I was captured, and anObject is answered to the frame that captured me."

	| captured mine shared unwindContext unwindBlock abandoned |
	values ifNil: [ ^ self error: 'This continuation was never captured' ].
	captured := self capturedContexts.
	mine := captured asIdentitySet.
	shared := thisContext findContextSuchThat: [ :each | mine includes: each ].
	shared ifNil: [ self signalIfAnotherProcessRuns: captured last ].
	unwindContext := thisContext findNextUnwindContextUpTo: shared.
	[ unwindContext isNil ] whileFalse: [
		unwindContext unwindComplete ifNil: [
			unwindContext unwindComplete: true.
			unwindBlock := unwindContext unwindBlock.
			thisContext terminateTo: unwindContext.
			unwindBlock value ].
		unwindContext := unwindContext findNextUnwindContextUpTo: shared ].
	[ (abandoned := thisContext sender) isNil or: [ abandoned == shared ] ]
		whileFalse: [
			thisContext swapSender: abandoned sender.
			abandoned terminate ].
	self restoreValues.
	thisContext swapSender: values first.
	^ anObject