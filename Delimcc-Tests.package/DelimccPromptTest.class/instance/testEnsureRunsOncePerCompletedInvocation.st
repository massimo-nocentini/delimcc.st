tests - exceptions
testEnsureRunsOncePerCompletedInvocation
	"The semantics of Kiselyov's delimcc: a capture runs no unwind block, and each invocation of k that completes runs its copy of the ensure: block."

	| k |
	self assert: (p delimit: [ [ p shift: [ :kk | (kk value: 1) + (kk value: 2) ] ] ensure: [ log add: #ensure ] ]) equals: 3.
	self assert: log asArray equals: #( #ensure #ensure ).
	log removeAll.
	k := p delimit: [ [ p shift: [ :kk | kk ] ] ensure: [ log add: #ensure ] ].
	self assert: log isEmpty.
	self assert: (k value: 7) equals: 7.
	self assert: log asArray equals: #( #ensure )