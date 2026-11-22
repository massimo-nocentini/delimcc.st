tests - derived
testShiftDelimitsKAndControlDoesNot
	"k of shift ends with the delimiter, so an abort in the code that k runs stops there; k of control does not, so the abort leaves the block too."

	| k |
	self assert: (p delimit: [ (p shift: [ :kk | (kk value: 1) + 100 ]) + (p abort: 5) ]) equals: 105.
	self assert: (p delimit: [ (p control: [ :kk | (kk value: 1) + 100 ]) + (p abort: 5) ]) equals: 5.
	k := p delimit: [ 1 + (p shift0: [ :kk | kk ]) ].
	self assert: k stack last receiver identicalTo: p.
	self assert: k stack last selector equals: #delimit:.
	self assert: k prompt identicalTo: p