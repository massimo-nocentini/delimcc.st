tests - snapshots
testRestoreGivesEachContextItsSnapshot
	"#restoreValues gives each captured context the state of its snapshot: to contexts whose frames are still on the stack, married ones that storing the pc moves to the heap first, and to contexts that no frame holds any more, those of a process that has ended. Both captures start from a sender of the running frame, which is suspended in the same send at the capture and at the restore, so the restore changes nothing that runs."

	| check live returned done process |
	check := [ :continuation |
	         | v |
	         v := continuation instVarNamed: #values.
	         (1 to: v size by: 2) allSatisfy: [ :i |
		         | context snapshot |
		         context := v at: i.
		         snapshot := v at: i + 1.
		         ((1 to: Context instSize) allSatisfy: [ :j |
			          (context instVarAt: j) == (snapshot instVarAt: j) ]) and: [
			         context size = snapshot size and: [
				         (1 to: context size) allSatisfy: [ :j |
					         (context at: j) == (snapshot at: j) ] ] ] ] ].
	live := self depth: 50 do: [
		        | continuation |
		        continuation := Continuation fromContext: thisContext sender.
		        continuation restoreValues.
		        check value: continuation ].
	self assert: live.
	done := Semaphore new.
	process := [
	           returned := self depth: 50 do: [
		                       Continuation fromContext: thisContext sender ].
	           done signal ] forkAt: Processor activePriority + 1.
	self deny: (done waitTimeoutMilliseconds: 1000).
	self assert: process isTerminated.
	self assert: returned hasSnapshots.
	returned restoreValues.
	self assert: (check value: returned)