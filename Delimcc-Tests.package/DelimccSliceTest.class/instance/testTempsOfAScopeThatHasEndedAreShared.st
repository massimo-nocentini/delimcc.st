tests - limits
testTempsOfAScopeThatHasEndedAreShared
	"x is a temporary of a loop body, in a temp vector of its own at each iteration. A block of an iteration that has ended runs in k, but no context of k holds its vector any more, as the body has returned or, inlined, has put the vector of the next iteration in the same temporary: the invocations share it, as a heap object. Only the block of the last iteration of an inlined loop gets its own x in each invocation."

	| k blocks inlined notInlined |
	inlined := [ :i |
	           {
		           [
		           blocks := Array new: 2.
		           1 to: 2 do: [ :j |
			           | x |
			           x := 0.
			           blocks at: j put: [
				           [ :kk |
				           k := kk.
				           #captured ] shift.
				           x := x + 1.
				           x ] ].
		           (blocks at: i) value ] reset.
		           (k value: nil).
		           (k value: nil).
		           (k value: nil) } ].
	notInlined := [ :i |
	              {
		              [
		              blocks := Array new: 2.
		              #( 1 2 ) do: [ :j |
			              | x |
			              x := 0.
			              blocks at: j put: [
				              [ :kk |
				              k := kk.
				              #captured ] shift.
				              x := x + 1.
				              x ] ].
		              (blocks at: i) value ] reset.
		              (k value: nil).
		              (k value: nil).
		              (k value: nil) } ].
	self assert: (inlined value: 1) equals: #( #captured 1 2 3 ).
	self assert: (inlined value: 2) equals: #( #captured 1 1 1 ).
	self assert: (notInlined value: 1) equals: #( #captured 1 2 3 ).
	self assert: (notInlined value: 2) equals: #( #captured 1 2 3 )