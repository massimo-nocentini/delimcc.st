helpers
withOneTempVector
	"x is written after the block captures it, so the method keeps it in a temp vector, after a."

	| a x |
	a := { 1 }.
	x := 0.
	^ [ x := x + a size ]