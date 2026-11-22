tests - rules
testRuleOfTheClosuresOfTheFrames
	"R2: the closure that a frame runs is re-pointed, so its ^ finds the copy of its home."

	self assertRule: #closureOrNil isNeededBy: #shotsOfAReturnBy: answering: #( 2 3 )