helpers
answerOf: anExample
	"Answer the printString that the last line of anExample shows: ""--> 121"" shows 121."

	| last |
	last := anExample lines last.
	^ last copyFrom: 6 to: last size - 1