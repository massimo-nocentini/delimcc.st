tests - structure
testPlainSlices
	"Nothing in these slices refers to another of their contexts: their templates are plain. A slice with the temp vector of inject:into: is not."

	| k |
	k := [ 1 + [ :kk | kk ] shift ] reset.
	k value: 1.
	self assert: k template isPlain.
	k := [ (true extractDelimcc and: [ false extractDelimcc ]) ifTrue: [ 1 ] ifFalse: [ 2 ] ] hansei.
	k value: true.
	self assert: k template isPlain.
	self assert: k template frames size > 3.
	k := [ (1 to: 3) inject: 0 into: [ :sum :i | sum + i extractDelimcc ] ] reset.
	k value: 1.
	self deny: k template isPlain