helpers
returnOfTwoShots
	"A ^ from a block of the slice, in each of two invocations."

	#( 1 ) do: [ :x |
		| v |
		v := [ :k | (k value: 10) + (k value: 20) ] shift.
		^ v ].
	^ 0