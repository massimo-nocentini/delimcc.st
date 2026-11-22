*Delimcc-Continuation-Tests-api
T: anObj
	"Answer whether the atom after anObj equals it, or whether two equal atoms follow each other later. #tree: ends the walk with me."

	| n |
	n := self getNext: anObj.
	^ n == self
		  ifTrue: [ false ]
		  ifFalse: [ n = anObj or: [ self T: n ] ]