tests - structure
testContextOfKIsACopy
	"Once k has been invoked, k context answers a copy of its template, so changing it, as an inspector may, changes no later invocation (review-perf 4d)."

	| k |
	k := [
	     | x |
	     x := 5.
	     [ :kk | kk ] shift.
	     x ] reset.
	self assert: (k value: nil) equals: 5.
	k context tempAt: 1 put: 99.
	self assert: (k value: nil) equals: 5