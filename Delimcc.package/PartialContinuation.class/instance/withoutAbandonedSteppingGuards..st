private
withoutAbandonedSteppingGuards: someContexts
	"Answer someContexts, my own contexts top first, chained again without the contexts that the debugger inserted to step over a send for a step that cannot end (Context>>#isAbandonedSteppingGuardDelimcc), such as the step over a capture whose k escapes: they would jump back into it. The guards of a step that goes on are kept, so that it sees my contexts return. My template has left out every guard (DelimccSliceCopier>>#leaveOutSteppingGuards), so someContexts have none when it has as many contexts."

	| kept |
	template frames size = someContexts size ifTrue: [ ^ someContexts ].
	kept := someContexts reject: [ :each | each isAbandonedSteppingGuardDelimcc ].
	kept withIndexDo: [ :each :index | each privSender: (kept at: index + 1 ifAbsent: [ nil ]) ].
	^ kept