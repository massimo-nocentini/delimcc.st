tests - ensure
testUnwindRunsTheUnwindBlocksInnermostFirst
	"k unwind runs the ensure: and ifCurtailed: blocks of a k that has never been invoked, as if it were unwound; k can be invoked afterwards, with copies, which run their own ensure: blocks."

	| k |
	k := [ [ [ [ :kk | kk ] shift ] ensure: [ log add: #ensure ] ] ifCurtailed: [ log add: #curtailed ] ] reset.
	k unwind.
	self assert: log asArray equals: #( #ensure #curtailed ).
	self assert: (k value: 3) equals: 3.
	self assert: log asArray equals: #( #ensure #curtailed #ensure )