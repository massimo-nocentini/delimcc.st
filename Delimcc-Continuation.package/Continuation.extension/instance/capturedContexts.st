*Delimcc-Continuation-private
capturedContexts
	"Answer the contexts that I restore, from the top one to the bottom one, in either layout of values (see #hasSnapshots).
	In the stock layout, #initializeFromContext: saved each context, then its instance variables, then as many stack slots as its stackp tells, which is the size that #restoreSlotValues reads back once stackp is restored."

	| contexts index context stackpIndex |
	self hasSnapshots ifTrue: [
		^ (1 to: values size by: 2) collect: [ :each | values at: each ] ].
	contexts := OrderedCollection new.
	stackpIndex := Context instVarIndexFor: #stackp ifAbsent: [ ^ self error: 'Context has no stackp' ].
	index := 1.
	[ index <= values size ] whileTrue: [
		context := values at: index.
		contexts add: context.
		index := index + 1 + context class instSize
			+ ((values at: index + stackpIndex) ifNil: [ 0 ]) ].
	^ contexts