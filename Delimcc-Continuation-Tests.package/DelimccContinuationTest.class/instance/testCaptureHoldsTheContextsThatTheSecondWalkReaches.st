tests - snapshots
testCaptureHoldsTheContextsThatTheSecondWalkReaches
	"#initializeFromContext: counts the frames in a first walk and saves them in a second one. When the captured stack belongs to another process, that process can run in between and return from captured frames, or rewire a sender. The capture is simulated here, and the chain changes right after the first walk: cut below its second context, cut below its top one, or grown below its bottom one. Each time values holds one pair (context, snapshot) for each context that the second walk reaches, and nothing else, so #hasSnapshots, #capturedContexts and #restoreValues read it."

	| method contexts captureChanging check |
	method := self class >> #depth:do:.
	contexts := OrderedCollection new.
	5 timesRepeat: [
		contexts addFirst: (Context
				 sender: (contexts ifEmpty: [ nil ] ifNotEmpty: [ contexts first ])
				 receiver: self
				 method: method
				 arguments: { 0. [ 0 ] }) ].
	captureChanging := [ :changeBlock |
	                   | continuation changed |
	                   continuation := Continuation basicNew.
	                   changed := false.
	                   thisContext
		                   runSimulated: [
		                   continuation initializeFromContext: contexts first ]
		                   contextAtEachStep: [ :each |
			                   (changed not and: [
				                    (continuation instVarNamed: #values) notNil ])
				                   ifTrue: [
					                   changed := true.
					                   changeBlock value ] ].
	                   self assert: changed.
	                   continuation ].
	check := [ :continuation :expected |
	         | v |
	         v := continuation instVarNamed: #values.
	         self assert: v size equals: 2 * expected size.
	         self deny: (v includes: nil).
	         self assert: continuation hasSnapshots.
	         self assert: continuation capturedContexts asArray equals: expected.
	         1 to: v size by: 2 do: [ :i |
		         self deny: (v at: i + 1) == (v at: i).
		         self assert: (v at: i + 1) sender identicalTo: (v at: i) sender.
		         self assert: (v at: i + 1) pc equals: (v at: i) pc ].
	         continuation restoreValues.
	         self assert: continuation capturedContexts asArray equals: expected ].
	check
		value: (captureChanging value: [ (contexts at: 2) privSender: nil ])
		value: (contexts first: 2) asArray.
	(contexts at: 2) privSender: (contexts at: 3).
	check
		value: (captureChanging value: [ contexts first privSender: nil ])
		value: { contexts first }.
	contexts first privSender: (contexts at: 2).
	check
		value: (captureChanging value: [
				 contexts last privSender: (Context
						  sender: nil
						  receiver: self
						  method: method
						  arguments: { 0. [ 0 ] }) ])
		value: (contexts copyWith: contexts last sender) asArray