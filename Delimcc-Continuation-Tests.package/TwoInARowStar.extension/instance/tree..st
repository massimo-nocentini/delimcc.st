*Delimcc-Continuation-Tests-api
tree: aTree
	"Answer whether two equal atoms follow each other when aTree is walked depth first.
	The end of the walk passes me, not nil: no tree holds me, so that every object can be an atom, numbers and nil included."

	| fst |
	fst := Continuation currentDo: [ :here |
		       leave := here.
		       self waddle: aTree.
		       leave value: self ].
	^ fst == self
		  ifTrue: [ false ]
		  ifFalse: [ self T: fst ]