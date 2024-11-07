*Delimcc
reset

	| context |
	context := thisContext.

	"context at: 1 put: context."

	^ [ self resetContext: context ] ensure: [ context at: 1 put: nil ]