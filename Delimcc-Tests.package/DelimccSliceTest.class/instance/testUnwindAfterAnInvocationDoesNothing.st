tests - ensure
testUnwindAfterAnInvocationDoesNothing
	"Once k has been invoked, each invocation has run its own unwind blocks."

	| k |
	k := [ [ [ :kk | kk ] shift ] ensure: [ log add: #ensure ] ] reset.
	k value: 1.
	k unwind.
	self assert: log asArray equals: #( #ensure ).
	k value: 2.
	k unwind.
	self assert: log asArray equals: #( #ensure #ensure )