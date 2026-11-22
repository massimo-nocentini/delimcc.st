helpers
returnThroughAWrapperOfK
	"The block of the slice is held by the closure of a method that has returned, which no frame runs."

	| block |
	block := self wrap: [ :x | ^ x * 10 ].
	^ block value: [ :k | k ] shift