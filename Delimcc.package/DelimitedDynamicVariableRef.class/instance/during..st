controlling
during: aBlock
	"Evaluate aBlock with me as the binding of my dynVar: this context is what DelimitedDynamicVariable>>#bindingIfNone: looks for, so I only evaluate aBlock."

	^ aBlock value