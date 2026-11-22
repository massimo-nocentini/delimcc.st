derived
control: aBlock
	"Like #control0:, but aBlock is evaluated delimited by me: this is the control of Felleisen. k does not hold my delimiter, so the captures of the code that k runs reach past it."

	| k |
	k := self cutSendersOf: thisContext includingDelimiter: false.
	^ self delimit: [ aBlock value: k ]