controlling
dlet: someValues in: aBlock
	"Bind each of my variables to the value at the same index while aBlock is evaluated, nesting their #dlet:in: so that the first occurrence of a variable listed twice wins."

	variables size = someValues size ifFalse: [
		Error signal: ('Cannot set {1} dynamic variables with {2} values' format: {variables size. someValues size})].
	^ ((1 to: variables size) inject: aBlock into: [ :block :i |
		   [ (variables at: i) dlet: (someValues at: i) in: block ] ]) value