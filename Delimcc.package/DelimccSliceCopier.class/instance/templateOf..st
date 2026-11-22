copying
templateOf: anArray

	| below |
	frames := anArray.
	copies := Array new: frames size.
	below := nil.
	frames size to: 1 by: -1 do: [ :i |
		below := copies at: i put: ((frames at: i) shallowCopy
				          privSender: below;
				          yourself) ].
	frames size to: 1 by: -1 do: [ :i | self fixFrame: i ].
	current := 0.
	[ pending isEmptyOrNil ] whileFalse: [ self fixObject: pending removeFirst ].
	^ DelimccSliceTemplate
		  frames: copies
		  objects: (objects ifNil: [ #(  ) ] ifNotNil: [ objects asArray ])
		  patches: (patches ifNil: [ #(  ) ] ifNotNil: [ patches asArray ])