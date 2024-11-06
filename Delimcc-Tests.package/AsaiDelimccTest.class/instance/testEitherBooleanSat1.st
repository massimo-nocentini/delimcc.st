tests
testEitherBooleanSat1

	| sols choices |
	choices := { true. false }.

	sols := [
	        | p q |
	        p := choices collectShift.
	        q := choices collectShift.

	        p | q & (p | q not) & (p not | q not)
		        ifTrue: [
			        {
				        (#p -> p).
				        (#q -> q) } ]
		        ifFalse: [ #fail ] ] reset.

	self assert: sols equals: {
			{
				#fail.
				{
					(#p -> true).
					(#q -> false) } }.
			{ #fail. #fail } }