codes
codeOfContext: aContext
	"R6 and R9: answer the index of aContext among my contexts, the code of its copy when it is the context of a block whose home is one of them (#codeOfDeadContext:), or 0."

	| index |
	index := self indexOfFrame: aContext.
	index = 0 ifTrue: [ ^ self codeOfDeadContext: aContext ].
	^ index