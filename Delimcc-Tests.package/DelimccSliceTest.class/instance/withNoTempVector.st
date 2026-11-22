helpers
withNoTempVector
	"x is captured but never written after the capture, so it is copied into the block; a is a brace array."

	| a x |
	a := { 1. 2 }.
	x := a size.
	^ [ x + a size ]