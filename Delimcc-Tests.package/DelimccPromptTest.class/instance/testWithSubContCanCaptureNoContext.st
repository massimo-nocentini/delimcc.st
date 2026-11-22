tests - basics
testWithSubContCanCaptureNoContext
	"Captured right above its delimiter, k has no context: it answers what it is given, as the empty subcontinuation of Dybvig, Peyton Jones and Sabry."

	| k |
	k := p delimit: [ p cutSendersOf: thisContext includingDelimiter: false ].
	self assert: k stack isEmpty.
	self assert: (k value: 5) equals: 5.
	self assert: (k pushSubCont: [ 6 ]) equals: 6.
	self assert: k prompt identicalTo: p