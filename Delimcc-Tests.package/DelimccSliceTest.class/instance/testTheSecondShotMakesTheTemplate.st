tests - structure
testTheSecondShotMakesTheTemplate
	"The first invocation of a k deeper than 16 contexts keeps a DelimccSliceSnapshot of it, a plain copy of its contexts and of the temp vectors that they have created, and the second one makes the template from it: such a k invoked once, as by a generator, never runs DelimccSliceCopier (review-perf 1). x is in a temp vector, which the snapshot keeps as it was when the first invocation began, so the second one adds 0 too. A shallower k is fixed at once."

	| k |
	k := [
	     | x |
	     x := 0.
	     [ x := (self deep: 20) + x ] value.
	     x ] reset.
	self assert: (k value: 1) equals: 21.
	self deny: k template isFixed.
	self assert: (k value: 2) equals: 22.
	self assert: k template isFixed.
	self assert: (k value: 3) equals: 23.
	k := [ 1 + [ :kk | kk ] shift ] reset.
	self assert: (k value: 1) equals: 2.
	self assert: k template isFixed