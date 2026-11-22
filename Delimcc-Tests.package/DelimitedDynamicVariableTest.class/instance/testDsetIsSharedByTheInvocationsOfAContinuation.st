testing
testDsetIsSharedByTheInvocationsOfAContinuation
	"A dlet captured by a continuation is one binding, which all the invocations of the continuation share."
	| p k |
	p := DelimitedDynamicVariable default: 0.
	k := [ p dlet: 1 in: [
		[ :c | c ] shift.
		p dset: p dref + 1.
		p dref ] ] reset.
	self assert: #(2 3) equals: { k value: nil. k value: nil }.
	self assert: 0 equals: p dref