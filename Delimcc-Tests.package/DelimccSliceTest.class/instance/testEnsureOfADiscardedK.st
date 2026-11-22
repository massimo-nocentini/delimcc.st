tests - ensure
testEnsureOfADiscardedK
	"A capture runs no unwind block, and neither does a continuation that is never invoked."

	self assert: { [ [ [ :k | 42 ] shift ] ensure: [ log add: #ensure ] ] reset. log asArray } equals: #( 42 #(  ) ).
	self assert: { [ [ [ :k | 42 ] shift ] ifCurtailed: [ log add: #curtailed ] ] reset. log asArray } equals: #( 42 #(  ) )