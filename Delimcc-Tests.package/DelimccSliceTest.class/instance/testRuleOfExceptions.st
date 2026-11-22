tests - rules
testRuleOfExceptions
	"R4: an exception that refers to the contexts of the slice is copied."

	self assertRule: #exceptions isNeededBy: #shotsOfAReturnFromAHandlerBy: answering: #( 1 2 )