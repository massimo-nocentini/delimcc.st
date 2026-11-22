accessing
dref
	"Answer my value in the innermost #dlet:in: on the call stack, or my default."

	^ (self bindingIfNone: [ ^ default ]) value