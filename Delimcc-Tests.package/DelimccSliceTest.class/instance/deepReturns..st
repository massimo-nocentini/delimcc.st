helpers
deepReturns: n
	"Each level has a block whose home is in the slice, and returns from it with ^."

	n = 0 ifTrue: [ ^ [ :k | k ] shift ].
	#( 1 ) do: [ :x | ^ 1 + (self deepReturns: n - 1) ].
	^ 0