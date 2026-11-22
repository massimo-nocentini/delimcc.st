tests - structure
testTemplateIsMadeAtTheFirstShot

	| k |
	k := [ 1 + [ :kk | kk ] shift ] reset.
	self assert: k template isNil.
	self assert: k stack last selector equals: #delimit:.
	self assert: (k value: 1) equals: 2.
	self deny: k template isNil.
	self assert: k stack last selector equals: #delimit:.
	self assert: (k instVarNamed: #from) isNil.
	self assert: (k value: 2) equals: 3