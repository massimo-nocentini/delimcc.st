testing
hasACopyOfEach: someContexts
	"Answer whether the contexts of my template are copies of each of someContexts, the contexts that I was made from, which they are unless some are stepping guards, which the copier leaves out. This makes no template."

	^ someContexts noneSatisfy: [ :each | each isSteppingGuardDelimcc ]