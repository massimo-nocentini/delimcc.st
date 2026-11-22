private
instantiateCopies: someContexts
	"someContexts are the copies of my originals that callcc made: keep their template, in which the references to the originals are re-pointed to the copies and the temp vectors are shared, and answer a fresh copy of it."

	template := DelimccSliceCopier templateSharingTempVectorsOf: someContexts for: originals.
	originals := nil.
	^ template instantiate