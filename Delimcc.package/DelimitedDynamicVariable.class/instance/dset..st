controlling
dset: anObject
	"Set my value in the innermost #dlet:in: on the call stack, or my default when there is none."

	(self bindingIfNone: [
		 | oldValue |
		 oldValue := default.
		 default := anObject.
		 ^ oldValue ]) value: anObject.
	^ anObject