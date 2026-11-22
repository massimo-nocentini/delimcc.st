testing
isDelimiting
	"Answer whether a delimiter of mine is on the stack of my sender, Kiselyov's is_prompt_set."

	^ (self delimiterFrom: thisContext sender) notNil