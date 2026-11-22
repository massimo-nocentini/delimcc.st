testing
testShiftPreservesResetMarker
	| cc |
	[1 + [:k | cc := k. k value: 2] shift] reset.
	self assert: cc stack last method equals: DelimccPrompt >> #delimit:.
	self assert: cc stack last receiver identicalTo: DelimccPrompt reset.
	self deny: ((cc stack collect: [ :each | each method selector ]) includes: #reset) description: 'Partial continuation cut too far, eating the reset'.

	"k holds the delimiter, so a shift inside an invocation of k stops there."
	cc := [ 1 + [ :k | k ] shift + [ :k | 100 ] shift ] reset.
	self assert: (cc value: 2) equals: 100