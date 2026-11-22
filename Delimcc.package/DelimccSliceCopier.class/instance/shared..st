private
shared: anObject
	"Remember that anObject, a closure or an Array, is shared by the copies, and answer its code, 0."

	(shared ifNil: [ shared := IdentitySet new ]) add: anObject.
	^ 0