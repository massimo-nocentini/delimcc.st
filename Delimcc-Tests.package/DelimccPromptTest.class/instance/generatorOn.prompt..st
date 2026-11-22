helpers
generatorOn: aTree prompt: aPrompt
	"The first step of a generator of the leaves of aTree: nil when there is none, else the leaf and the continuation that walks to the next one."

	^ aPrompt delimit: [
		  self walk: aTree yield: [ :leaf | aPrompt withSubCont: [ :k | { leaf. k } ] ].
		  nil ]