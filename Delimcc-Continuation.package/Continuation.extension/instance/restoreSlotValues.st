*Delimcc-Continuation-private
restoreSlotValues
	"Restore a continuation captured in the stock layout (see #hasSnapshots), as the stock #restoreValues did: each context gets its instance variables and its stack slots back, one #instVarAt:put: or #at:put: per slot."

	| valueStream context |
	valueStream := values readStream.
	[ valueStream atEnd ] whileFalse: [
		context := valueStream next.
		1 to: context class instSize do: [ :i |
			context instVarAt: i put: valueStream next ].
		1 to: context size do: [ :i | context at: i put: valueStream next ] ]