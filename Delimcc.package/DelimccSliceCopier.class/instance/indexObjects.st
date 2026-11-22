private
indexObjects

	codes := IdentityDictionary new: originals size * 2.
	originals doWithIndex: [ :each :i | codes at: each put: 0 - i ]