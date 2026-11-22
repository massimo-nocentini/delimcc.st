controlling
dset: anObject
	"Set my value in the innermost #dlet:in: on the call stack, or my default when there is none, and answer anObject."

	(self bindingIfNone: [ ^ default := anObject ]) value: anObject.
	^ anObject