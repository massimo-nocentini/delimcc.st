*Delimcc
collectShift: aBlock

	^ [ :k |
	  | dict |
	  dict := self class new: self size.

	  self keysAndValuesDo: [ :each :v |
		  | w |
		  w := aBlock value: each value: v.
		  dict at: each put: w ].

	  dict ] shift