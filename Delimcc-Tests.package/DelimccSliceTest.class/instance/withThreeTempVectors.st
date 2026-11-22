helpers
withThreeTempVectors
	"x, y and z are written by the innermost block, so the method and the two outer blocks keep each one in a temp vector of its own."

	| x |
	x := 0.
	^ [ :a |
	  | y |
	  y := a.
	  [ :b |
	  | z |
	  z := b.
	  [ x := y := z := x + y + z ] ] ]