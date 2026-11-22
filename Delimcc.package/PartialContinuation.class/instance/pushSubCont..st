evaluating
pushSubCont: aBlock
	"Run my contexts on top of the current call stack, evaluate aBlock on top of them and answer what they answer. This is pushSubCont of Dybvig, Peyton Jones and Sabry, of which value: anObject is pushSubCont: [ anObject ]."

	self insertBelow: thisContext.
	^ aBlock value