helpers
returnThroughATempVector
	"blk is in a temp vector, since the block reader reads it and it is assigned after."

	| blk r reader |
	reader := [ blk ].
	blk := [ :v | ^ v * 10 ].
	r := [ :k | (k value: 1) + (k value: 2) ] shift.
	^ reader value value: r