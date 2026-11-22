private
instantiateCopies: someContexts
	"someContexts are the copies of my originals that callcc made: keep their template and answer a fresh copy of it."

	self keepTemplateOfCopies: someContexts.
	^ template instantiate