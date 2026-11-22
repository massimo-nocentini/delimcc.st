*Delimcc
collectShift: aBlock
	"Like Collection>>#collectShift:, for my values: answer a dictionary with my keys, each bound to what the continuation answers for aBlock applied to the key and its value."

	^ [ :k |
	  | dict |
	  dict := self class new: self size.

	  self keysAndValuesDo: [ :each :v |
		  dict at: each put: (k value: (aBlock value: each value: v)) ].

	  dict ] shift