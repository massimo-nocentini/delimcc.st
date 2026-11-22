tests - ensure
testAnInvocationAfterUnwindRunsACopy
	"k unwind takes the place of the first invocation, so k can still be invoked: a later invocation runs a fresh copy, as after any first invocation, on the state that the unwind blocks have left, here a closed generator (review-semantics 6). open is below the reset, so the copies share it."

	| open k |
	open := false.
	k := [
	     [
	     open := true.
	     #( 1 2 3 ) do: [ :x |
		     [ :kk | kk ] shift.
		     log add: (open
				      ifTrue: [ x ]
				      ifFalse: [ #readAfterClose ]) ] ] ensure: [
		     open := false.
		     log add: #closed ] ] reset.
	k unwind.
	self assert: log asArray equals: #( #closed ).
	self assert: (k value: nil) class equals: PartialContinuation.
	self assert: log asArray equals: #( #closed #readAfterClose )