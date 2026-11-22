evaluating
pushSubCont: aBlock
	"Run a copy of my contexts on top of the current call stack, evaluate aBlock on top of them and answer what they answer. This is pushSubCont of Dybvig, Peyton Jones and Sabry, of which value: anObject is pushSubCont: [ anObject ]."

	self insertCopyBelow: thisContext.
	^ aBlock value