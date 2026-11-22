private
dictionaryOf: someSnapshots
	"Answer the copies of someSnapshots, the objects that I have copied each followed by its copy, by object, or nil when there is none."

	| dictionary |
	someSnapshots ifNil: [ ^ nil ].
	dictionary := IdentityDictionary new: someSnapshots size.
	1 to: someSnapshots size by: 2 do: [ :i | dictionary at: (someSnapshots at: i) put: (someSnapshots at: i + 1) ].
	^ dictionary