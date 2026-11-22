helpers
tempOutsideTheSlice
	"x is a temporary of this method, below the reset, so the invocations share it."

	| x r |
	x := 0.
	r := [
	     [ :k | (k value: 1) + (k value: 1) ] shift.
	     x := x + 1.
	     x ] reset.
	^ { r. x }