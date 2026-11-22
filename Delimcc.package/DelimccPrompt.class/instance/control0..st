derived
control0: aBlock
	"The same as #withSubCont:: k does not hold my delimiter and aBlock is evaluated without it."

	^ aBlock value: (self cutSendersOf: thisContext includingDelimiter: false)