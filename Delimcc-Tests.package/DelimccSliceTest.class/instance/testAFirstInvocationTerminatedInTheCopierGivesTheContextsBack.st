tests - structure
testAFirstInvocationTerminatedInTheCopierGivesTheContextsBack
	"A first invocation is terminated while it makes the template of a deep k, as Abandon in the debugger does: it gives the contexts of k back, so an invocation that waits for the template runs them instead, and a later one runs a copy (review-semantics 3)."

	| k first |
	k := [ self deep: 50000 ] reset.
	first := [ k value: 0 ] forkAt: Processor activePriority - 1.
	[ (k instVarNamed: #from) notNil ] whileTrue: [ (Delay forMilliseconds: 1) wait ].
	[
	(Delay forMilliseconds: 10) wait.
	first terminate ] forkAt: Processor activePriority + 1.
	self assert: (self isolated: [ k value: 0 ]) equals: 50000.
	self assert: (self isolated: [ k value: 1 ]) equals: 50001