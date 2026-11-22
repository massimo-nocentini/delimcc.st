helpers
tempWrittenByABlock

	^ [
	  | x |
	  x := 0.
	  [ :k | (k value: 1) + (k value: 1) ] shift.
	  [ x := x + 1 ] value.
	  x ] reset