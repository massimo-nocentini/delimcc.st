private
framesForFirstShotFrom: aContext
	"Answer my contexts, from aContext down, which the first invocation has taken, once I have kept their template, or, for callcc, a fresh copy of the template made from them. When another invocation has kept a template meanwhile (#keep:), it has run my contexts, so answer a fresh copy of its template. Signal a DelimccResumedSliceError, before I keep anything, when a Continuation has resumed my contexts since my capture (#signalIfResumed:)."

	| frames |
	frames := self framesFrom: aContext upTo: nil.
	originals ifNotNil: [ ^ self instantiateCopies: frames ].
	self signalIfResumed: frames.
	(self keep: (DelimccSliceCopier templateOf: frames)) ifFalse: [ ^ template instantiate ].
	bottom := nil.
	^ self withoutAbandonedSteppingGuards: frames