tests - review 2
testHandlerSliceInOtherProcesses
	"#isolated: runs each invocation in a process of its own."

	| k |
	k := [ ([ 1 / 0 ] on: ZeroDivide do: [ :e | [ :kk | kk ] shift ]) * 10 ] reset.
	self assert: ((1 to: 2) collect: [ :i | self isolated: [ k value: i ] ]) equals: #( 10 20 )