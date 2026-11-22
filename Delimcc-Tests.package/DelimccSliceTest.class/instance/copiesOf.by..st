helpers
copiesOf: aContinuation by: aCopier
	"Make the template of aContinuation with aCopier before its first invocation, so that every invocation runs copies that aCopier has fixed."

	| top |
	top := aContinuation instVarNamed: #from.
	aContinuation instVarNamed: #from put: nil.
	aContinuation instVarNamed: #template put: (aCopier templateOf: (aContinuation framesFrom: top)).
	^ aContinuation