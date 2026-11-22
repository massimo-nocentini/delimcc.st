helpers
tempReadByABlock
	"x is captured by a block and written after, so the compiler keeps it in a temp vector."

	^ [
	  | x block |
	  x := 0.
	  block := [ x ].
	  [ :k | (k value: 1) + (k value: 1) ] shift.
	  x := x + 1.
	  block value ] reset