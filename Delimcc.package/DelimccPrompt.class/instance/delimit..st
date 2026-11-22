controlling
delimit: aBlock
	"Evaluate aBlock delimited by me: this context is the delimiter that #delimiterFrom: looks for, so I only evaluate aBlock."

	^ aBlock value