*Delimcc
reset

	| context v |
	context := thisContext.

	context at: 1 put: context.

	v := self resetContext: context.

	context at: 1 put: nil.

	^ v