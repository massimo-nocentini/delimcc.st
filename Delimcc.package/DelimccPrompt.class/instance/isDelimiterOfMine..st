private
isDelimiterOfMine: aContext
	"Answer whether aContext evaluates #delimit: on me. The selector is compared, not the method, so a continuation captured before #delimit: was recompiled still holds a delimiter."

	^ aContext receiver == self and: [ aContext selector == #delimit: ]