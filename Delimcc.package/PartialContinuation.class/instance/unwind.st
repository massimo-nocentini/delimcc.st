evaluating
unwind
	"Run the ensure: and ifCurtailed: blocks of my contexts, innermost first, as for a continuation that will never be invoked, such as an abandoned generator. This takes the place of my first invocation, which unwinds my contexts instead of running them; I keep their template first, so I can still be invoked, with fresh copies. Do nothing once I have been invoked, as each invocation has run or unwound its own contexts. Signal a DelimccResumedSliceError, as my first invocation does, when a Continuation has resumed my contexts since my capture (#signalIfResumed:)."

	| top frames |
	template ifNotNil: [ ^ self ].
	top := from.
	from := nil.
	"No send since template was tested, as in #framesForShot, which gives my contexts back in the same way."
	top ifNil: [ ^ self ].
	([
	 self signalIfResumed: (frames := self framesFrom: top upTo: nil).
	 self keep: (DelimccSliceCopier templateOf: frames) ] ifCurtailed: [ template ifNil: [ from := top ] ])
		ifTrue: [
			bottom := nil.
			(self withoutAbandonedSteppingGuards: frames) ifNotEmpty: [ :some | some first unwindTo: nil ] ]