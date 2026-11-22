*Delimcc-Continuation-private
scanForAnotherProcessRunning: aCollection
	"Answer the first process that Process allSubInstances answers, other than the active one and not terminated, whose stack holds one of the contexts in aCollection, or nil when there is none. See #anotherLiveProcessRunning:.
	I look for the contexts anywhere on the stack of each process, not only at its bottom: Process>>#terminate inserts contexts below the bottom context of a process that it terminates from another process."

	| active |
	active := Processor activeProcess.
	Process allSubInstancesDo: [ :each |
		(each ~~ active and: [
			 each isTerminated not and: [
				 each suspendedContext notNil and: [
					 (each suspendedContext findContextSuchThat: [ :context |
						  aCollection includes: context ]) notNil ] ] ])
			ifTrue: [ ^ each ] ].
	^ nil