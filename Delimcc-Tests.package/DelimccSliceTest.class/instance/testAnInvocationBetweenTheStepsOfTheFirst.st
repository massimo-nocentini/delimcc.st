tests - debugger
testAnInvocationBetweenTheStepsOfTheFirst
	"The debugger steps the first invocation of k one bytecode at a time, so another invocation runs between the two assignments with which the first takes the contexts of k (#framesForShot): both take them, and the stepped one, which keeps its template second, runs a fresh copy instead of the contexts that the other has run."

	self assert: (self isolated: [
			 | k result process context other |
			 k := [ 1 + [ :kk | kk ] shift ] reset.
			 result := #unfinished.
			 process := [ result := [ k value: 10 ] on: Error do: [ :e | e ] ] newProcess.
			 [
			 (context := process suspendedContext) method == (PartialContinuation >> #framesForShot) and: [
				 (context tempNamed: 'top') notNil and: [ (k instVarNamed: #from) notNil ] ] ] whileFalse: [ process step ].
			 other := k value: 20.
			 self stepToTheEnd: process.
			 {
				 other.
				 result.
				 (k value: 30) } ]) equals: #( 21 11 31 )