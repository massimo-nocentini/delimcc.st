tests - structure
testAnInvocationWaitsForTheTemplateOfAnother
	"A first invocation in another process has taken the contexts of k and is making its template: an invocation here waits for the template."

	| k top done |
	k := [ 1 + [ :kk | kk ] shift ] reset.
	top := k instVarNamed: #from.
	k instVarNamed: #from put: nil.
	done := Semaphore new.
	[
	(Delay forMilliseconds: 20) wait.
	k instVarNamed: #template put: (DelimccSliceCopier templateOf: (k framesFrom: top upTo: nil)).
	done signal ] forkAt: Processor activePriority - 1.
	self assert: (k value: 41) equals: 42.
	done wait.
	self assert: (k value: 1) equals: 2