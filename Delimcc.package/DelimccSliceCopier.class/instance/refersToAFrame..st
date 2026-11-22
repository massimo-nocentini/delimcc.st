private
refersToAFrame: anObject
	"Answer whether an instance variable of anObject is one of my contexts. They are compared by identity, with no send, since they may hold a ProtoObject, such as the signaler of an exception."

	1 to: anObject class instSize do: [ :i | (self indexOfFrame: (anObject instVarAt: i)) > 0 ifTrue: [ ^ true ] ].
	^ false