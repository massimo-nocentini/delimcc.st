tests - rules
testRuleOfReceivers
	"R2 and R3: the receivers of the frames and closures of the slice are re-pointed."

	self assertRule: #receivers isNeededBy: #shotsOfAHandlerSliceBy: answering: #( 10 20 )