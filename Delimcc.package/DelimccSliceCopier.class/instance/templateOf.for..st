copying
templateOf: someCopies for: someContexts
	"Answer the template whose contexts are someCopies, copies of someContexts made by #copiesOf:, in which the references to someContexts are re-pointed to someCopies. The slots are read in the copies, so the contexts may have run since they were copied. A misordered slice (#codeOfArray:) is fixed again, with its temp vectors registered first, which costs a scan of each context."

	frames := someContexts.
	copies := someCopies.
	self leaveOutSteppingGuards.
	self fixFrames.
	misordered ifTrue: [
		self
			forget;
			registerTempVectors;
			fixFrames ].
	^ DelimccSliceTemplate
		  frames: copies
		  objects: (objects ifNil: [ #(  ) ] ifNotNil: [ objects asArray ])
		  patches: (patches ifNil: [ #(  ) ] ifNotNil: [ patches asArray ])