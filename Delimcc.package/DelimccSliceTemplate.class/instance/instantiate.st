instantiating
instantiate
	"Answer fresh copies of my contexts, top first, chained, the bottom one with no sender, whose references to each other and to my objects are re-pointed to the copies."

	| copies below fresh |
	copies := Array new: frames size.
	below := nil.
	frames size to: 1 by: -1 do: [ :i |
		below := copies at: i put: ((frames at: i) shallowCopy
				          privSender: below;
				          yourself) ].
	patches isEmpty ifTrue: [ ^ copies ].
	fresh := objects collect: [ :each | each shallowCopy ].
	self patch: copies with: fresh.
	^ copies