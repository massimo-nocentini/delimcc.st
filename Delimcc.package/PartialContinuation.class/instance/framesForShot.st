private
framesForShot
	"Answer the contexts that an invocation runs, top first, the bottom one with no sender: my own contexts the first time, once I have kept their template, fresh copies from the template afterwards."

	| top frames |
	template ifNotNil: [ ^ template instantiate ].
	top := from.
	from := nil.
	"No send since template was tested, so a single invocation takes my contexts, even when other processes invoke me too: they wait for my template."
	top ifNil: [ ^ self awaitTemplate instantiate ].
	frames := self framesFrom: top.
	template := DelimccSliceCopier templateOf: frames.
	^ frames