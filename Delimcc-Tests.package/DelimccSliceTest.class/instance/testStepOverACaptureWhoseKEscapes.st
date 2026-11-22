tests - debugger
testStepOverACaptureWhoseKEscapes
	"The contexts that the debugger has inserted in k to step over its capture jump back into a step that has not ended when k escapes (#stepOverAnEscapeIn:), and would end the process of an invocation, so the first invocation leaves them out too, as #unwind does."

	| k |
	self stepOverAnEscapeIn: [ [ 10 + [ :kk | k := kk. 0 ] shift ] reset ].
	self assert: (self isolated: [ { k value: 1. k value: 2 } ]) equals: #( 11 12 ).
	self stepOverAnEscapeIn: [ [ [ 10 + [ :kk | k := kk. 0 ] shift ] ensure: [ log add: #unwound ] ] reset ].
	self assert: (self isolated: [ k unwind. log asArray ]) equals: #( #unwound )