helpers
heldReturnOf: aBlock
	"A heap object, I, holds a block that returns from this context with ^."

	| r |
	held := [ :v | ^ v * 100 ].
	r := aBlock shift.
	^ held value: r