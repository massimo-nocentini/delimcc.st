private
framesForFirstShotFrom: aContext
	"Answer my contexts, from aContext down, which the first invocation has taken, once I have kept their template, or, for callcc, a fresh copy of the template made from them."

	| frames |
	frames := self framesFrom: aContext upTo: nil.
	originals ifNotNil: [ ^ self instantiateCopies: frames ].
	template := DelimccSliceCopier templateOf: frames.
	^ frames