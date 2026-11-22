tests - rules
testRuleOfClosures
	"R3: a closure whose home is in the slice is copied, even when no frame runs it."

	self assertRule: #closures isNeededBy: #shotsOfAWrappedReturnBy: answering: #( 10 20 )