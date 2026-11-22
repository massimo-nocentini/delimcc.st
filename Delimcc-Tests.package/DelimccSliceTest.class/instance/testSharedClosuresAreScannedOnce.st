tests - structure
testSharedClosuresAreScannedOnce
	"A closure from below the slice is scanned once, with the closures in its copied values, however many fields hold it: here a DAG of 41 closures, each of which holds the one before twice, which would take 2 raised to 40 scans otherwise."

	| dag k |
	dag := [ 1 ].
	40 timesRepeat: [ dag := [ :a :b | [ a value + b value ] ] value: dag value: dag ].
	k := [
	     | held |
	     held := dag.
	     1 + [ :kk | kk ] shift ] reset.
	self assert: (self isolated: [ (k value: 1) + (k value: 2) ]) equals: 5