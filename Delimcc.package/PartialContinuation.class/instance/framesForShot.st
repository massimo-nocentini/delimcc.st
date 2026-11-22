private
framesForShot
	"Answer the contexts that an invocation runs, top first, the bottom one with no sender: my own contexts the first time, once I have kept their template, fresh copies from the template afterwards. A copy made by callcc never runs: the template is made from it."

	| top |
	template ifNotNil: [ ^ template instantiate ].
	top := from.
	from := nil.
	"No send since template was tested, so a single invocation takes my contexts, even when other processes invoke me too: they wait for my template."
	top ifNil: [
		self awaitTemplate.
		^ self framesForShot ].
	"An error or a terminate in the copier gives my contexts back, so that I stay invocable."
	^ [ self framesForFirstShotFrom: top ] ifCurtailed: [ template ifNil: [ from := top ] ]