copying
templateOf: someCopies for: someContexts
	"Answer the template whose contexts are someCopies, copies of someContexts made by #copiesOf:, in which the references to someContexts are re-pointed to someCopies. The slots are read in the copies, so the contexts may have run since they were copied."

	frames := someContexts.
	copies := someCopies.
	frames size to: 1 by: -1 do: [ :i | self fixFrame: i ].
	current := 0.
	[ pending isEmptyOrNil ] whileFalse: [ self fixObject: pending removeFirst ].
	^ DelimccSliceTemplate
		  frames: copies
		  objects: (objects ifNil: [ #(  ) ] ifNotNil: [ objects asArray ])
		  patches: (patches ifNil: [ #(  ) ] ifNotNil: [ patches asArray ])