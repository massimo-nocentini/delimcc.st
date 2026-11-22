helpers
returnThroughAWrapper
	"The block of the slice is held by the closure of a method that has returned: it is copied with the closure that holds it."

	| block r |
	block := self wrap: [ :x | ^ x * 10 ].
	r := [ :k | (k value: 1) + (k value: 2) ] shift.
	^ block value: r