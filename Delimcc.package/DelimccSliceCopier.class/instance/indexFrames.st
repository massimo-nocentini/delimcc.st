private
indexFrames

	frameIndexes := IdentityDictionary new: frames size * 3 // 2.
	frames doWithIndex: [ :each :i | frameIndexes at: each put: i ].
	^ frameIndexes