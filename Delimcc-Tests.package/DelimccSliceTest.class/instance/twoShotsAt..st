helpers
twoShotsAt: n
	"Capture a slice n contexts deeper than the sender, invoke it with 1 and 2, and answer the sum of what the invocations answer."

	^ n = 0
		  ifTrue: [ [ :k | (k value: 1) + (k value: 2) ] shift ]
		  ifFalse: [ 1 + (self twoShotsAt: n - 1) ]