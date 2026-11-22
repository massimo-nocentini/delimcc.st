private
copy: aContext upTo: anotherContext depth: anInteger
	"Answer a copy of aContext and of its senders down to anotherContext, excluded, chained, the bottom one with no sender, and keep these contexts in originals, top first. This is a recursion, as Context>>#copyTo: is, which copies a deep stack faster than a loop does."

	| copy |
	aContext == anotherContext ifTrue: [
		originals := Array new: anInteger.
		^ nil ].
	copy := aContext shallowCopy.
	copy privSender: (self copy: aContext sender upTo: anotherContext depth: anInteger + 1).
	originals at: anInteger + 1 put: aContext.
	^ copy