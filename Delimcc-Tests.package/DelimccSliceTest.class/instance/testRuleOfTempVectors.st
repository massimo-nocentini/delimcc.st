tests - rules
testRuleOfTempVectors
	"R5: the temp vectors of the slice are copied, so its temporaries are per invocation."

	self assertRule: #vectors isNeededBy: #shotsOfATempWrittenByABlockBy: answering: #( 1 1 )