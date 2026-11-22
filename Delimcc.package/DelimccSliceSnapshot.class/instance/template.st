accessing
template
	"Answer the DelimccSliceTemplate of my slice, which I make at the first call, and then drop what I made it from. Copies is read last and dropped first, so a process that reads it is sure of what it read before, and one that reads nil finds the template, which is kept before."

	| someFrames someSnapshots someCopies made |
	someFrames := frames.
	someSnapshots := snapshots.
	someCopies := copies.
	someCopies ifNil: [ ^ template ].
	made := DelimccSliceCopier new
		        snapshots: (self dictionaryOf: someSnapshots);
		        templateOf: (DelimccSliceCopier copiesOf: someCopies) for: someFrames.
	template ifNil: [ template := made ].
	copies := nil.
	frames := snapshots := nil.
	^ template