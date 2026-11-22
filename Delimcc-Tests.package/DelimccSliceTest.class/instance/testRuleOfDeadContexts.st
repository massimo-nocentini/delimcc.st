tests - rules
testRuleOfDeadContexts
	"R9: the context of a block that has returned is copied when its closure is, so that the closures that it made find the copy of their home."

	self assertRule: #deadContexts isNeededBy: #shotsOfAReturnThroughAReturnedBlockBy: answering: #( 10 20 )