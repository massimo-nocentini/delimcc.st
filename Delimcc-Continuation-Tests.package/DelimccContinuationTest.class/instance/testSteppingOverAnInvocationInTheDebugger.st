tests - fixes
testSteppingOverAnInvocationInTheDebugger
	"A debugger steps into a process and steps over its k value: send (Pharo issue #5878). Stepping over runs the send for real, on the debugger's process, on top of the frames that Context>>#runUntilErrorOrReturnFrom: puts there. A stock value: cut those frames too, so it killed the debugger's process: it ran the tail of the debugged process instead and never came back. Now the step comes back to the debugger, and stepping on finishes the debugged code as if it had run alone."

	| target debugged session done finished result outcome steps steppedOver debugger |
	shots := 0.
	target := self class >> #invokeKForTheDebugger.
	finished := false.
	steppedOver := 0.
	steps := 0.
	outcome := #notFinished.
	done := Semaphore new.
	debugged := [
	            result := self invokeKForTheDebugger.
	            finished := true ] newProcess.
	[
	session := debugged
		           newDebugSessionNamed: 'testSteppingOverAnInvocationInTheDebugger'
		           startedAt: debugged suspendedContext.
	debugger := [
	            [
	            [
	            [ finished not and: [ (steps := steps + 1) < 100000 ] ]
		            whileTrue: [
			            | context |
			            context := session interruptedContext.
			            (context method == target and: [
				             context instructionStream willSend and: [
					             context instructionStream selectorToSendOrSelf
					             == #value: ] ])
				            ifTrue: [
					            steppedOver := steppedOver + 1.
					            session stepOver: context ]
				            ifFalse: [ session stepInto: context ] ].
	            outcome := #finished ]
		            on: Error
		            do: [ :e | outcome := e ] ] ensure: [ done signal ] ]
		            fork.
	self deny: (done waitTimeoutMilliseconds: 5000).
	self assert: outcome equals: #finished.
	self assert: steppedOver equals: 1.
	self assert: result equals: 7.
	self assert: shots equals: 2 ] ensure: [
		{ debugger. debugged } do: [ :each |
			(each isNil or: [ each isTerminated ]) ifFalse: [
				[ each terminate ] on: Error do: [ :e | e return: nil ] ] ] ]
