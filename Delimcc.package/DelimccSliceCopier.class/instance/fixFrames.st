copying
fixFrames
	"Fix my contexts from the bottom up, then the objects that they refer to."

	frames size to: 1 by: -1 do: [ :i | self fixFrame: i ].
	current := 0.
	[ pending isEmptyOrNil ] whileFalse: [ self fixObject: pending removeFirst ]