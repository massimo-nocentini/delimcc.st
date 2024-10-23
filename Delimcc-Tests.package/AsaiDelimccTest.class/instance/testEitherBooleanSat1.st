tests
testEitherBooleanSat1

	| sols choices |
	choices := { true. false }.

	sols := Array streamContents: [ :s |
		        choices ? [ :p |
		        choices ? [ :q |
		        p | q & (p | q not) & (p not | q not) ifTrue: [
			        s nextPut: {
					        p.
					        q } ] ] ] ].

	self assert: sols equals: #( #( true false ) ).

	sols := choices ? [ :p |
	        choices ? [ :q |
	        p | q & (p | q not) & (p not | q not) ifTrue: [
		        {
			        p.
			        q } ] ] ].

	self assert: sols equals: #( #( nil #( true false ) )
	   #( nil nil ) )