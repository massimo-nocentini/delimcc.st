private
keepTemplateOfCopies: someContexts
	"someContexts are the copies of my originals that callcc made: keep their template, in which the references to the originals are re-pointed to the copies and the temp vectors are shared, unless another invocation has kept one meanwhile (#keep:)."

	self keep: (DelimccSliceCopier templateSharingTempVectorsOf: someContexts for: originals).
	originals := nil