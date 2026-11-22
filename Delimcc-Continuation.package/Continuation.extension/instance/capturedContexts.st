*Delimcc-Continuation-private
capturedContexts
	"Answer the contexts that I restore, from the top one to the bottom one.
	#initializeFromContext: saves each context, then its instance variables, then as many stack slots as its stackp tells, which is the size that #restoreValues reads back once stackp is restored."

	| contexts index context stackpIndex |
	contexts := OrderedCollection new.
	stackpIndex := Context instVarIndexFor: #stackp ifAbsent: [ ^ self error: 'Context has no stackp' ].
	index := 1.
	[ index <= values size ] whileTrue: [
		context := values at: index.
		contexts add: context.
		index := index + 1 + context class instSize
			+ ((values at: index + stackpIndex) ifNil: [ 0 ]) ].
	^ contexts