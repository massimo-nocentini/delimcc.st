copying
leaveOutSteppingGuards
	"Leave out of my copies the contexts that the debugger has inserted to step over a send (Context>>#isSteppingGuardDelimcc). They jump back into a debugging operation, which is over by the time a copy runs, so a copy must return through them as if they were not there. The contexts of the first invocation keep them."

	| kept |
	1 to: copies size do: [ :i |
		(copies at: i) isSteppingGuardDelimcc ifTrue: [
			kept := (1 to: copies size) reject: [ :each | (copies at: each) isSteppingGuardDelimcc ].
			frames := kept collect: [ :each | frames at: each ].
			copies := kept collect: [ :each | copies at: each ].
			copies withIndexDo: [ :each :index | each privSender: (copies at: index + 1 ifAbsent: [ nil ]) ].
			^ self ] ]