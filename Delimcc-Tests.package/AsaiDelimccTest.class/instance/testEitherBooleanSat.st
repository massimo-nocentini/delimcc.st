tests
testEitherBooleanSat

	| sols choices |
	choices := { true. false }.
	sols := Array streamContents: [ :s |
		        [
		        | p q |
		        p := choices collectShift.
		        q := choices collectShift.
		        p | q & (p | q not) & (p not | q not) ifTrue: [
			        s nextPut: {
					        p.
					        q } ] ] reset ].

	self assert: sols equals: #( #( true false ) )