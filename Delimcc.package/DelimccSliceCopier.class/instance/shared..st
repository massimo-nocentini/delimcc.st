private
shared: anObject
	"Remember that anObject, a closure or an Array, is shared by the copies, and answer its code, 0. The last one is kept apart, so that a slice that has one only, as most have, needs no set."

	lastShared ifNotNil: [ (shared ifNil: [ shared := IdentitySet new ]) add: lastShared ].
	lastShared := anObject.
	^ 0