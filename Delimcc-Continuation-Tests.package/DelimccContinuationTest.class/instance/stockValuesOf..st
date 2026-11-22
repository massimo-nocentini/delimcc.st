helpers
stockValuesOf: aContext
	"Answer the values that the stock Continuation>>#initializeFromContext: saves for aContext: each context, then its instance variables, then its stack slots up to stackp."

	| valueStream context |
	valueStream := WriteStream on: (Array new: 20).
	context := aContext.
	[ context isNotNil ] whileTrue: [
		valueStream nextPut: context.
		1 to: context class instSize do: [ :i |
			valueStream nextPut: (context instVarAt: i) ].
		1 to: context size do: [ :i | valueStream nextPut: (context at: i) ].
		context := context sender ].
	^ valueStream contents