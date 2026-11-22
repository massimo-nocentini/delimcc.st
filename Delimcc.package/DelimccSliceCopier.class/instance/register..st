copying
register: anObject
	"Copy anObject into the template, as my DelimccSliceSnapshot copied it if it did (#snapshotOf:), and answer the code of the copy. A few copies are found by a search of originals, many by codes."

	| code |
	originals ifNil: [
		originals := OrderedCollection new.
		objects := OrderedCollection new ].
	originals add: anObject.
	objects add: (self snapshotOf: anObject) shallowCopy.
	code := 0 - objects size.
	codes
		ifNil: [ originals size > 16 ifTrue: [ self indexObjects ] ]
		ifNotNil: [ codes at: anObject put: code ].
	^ code