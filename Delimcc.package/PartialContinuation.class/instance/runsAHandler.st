private
runsAHandler
	"Answer whether one of the contexts that callcc copied into me runs an exception handler (Context>>#evaluateSignal:)."

	| handler |
	handler := Context >> #evaluateSignal:.
	1 to: originals size do: [ :i | (originals at: i) method == handler ifTrue: [ ^ true ] ].
	^ false