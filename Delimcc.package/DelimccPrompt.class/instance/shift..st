derived
shift: aBlock
	"Like #shift0:, but aBlock is evaluated delimited by me too: this is the shift of Danvy and Filinski."

	| k |
	k := self cutSendersOf: thisContext includingDelimiter: true.
	^ self delimit: [ aBlock value: k ]