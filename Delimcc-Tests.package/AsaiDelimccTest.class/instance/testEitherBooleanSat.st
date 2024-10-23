tests
testEitherBooleanSat

	| sols choices |
	choices := { true. false }.
	sols := Array streamContents: [ :s |
		        [
		        | p q |
		        p := self delimccEither: choices.
		        [
		        q := self delimccEither: choices.
		        p | q & (p | q not) & (p not | q not) ifTrue: [
			        s nextPut: {
					        p.
					        q } ] ] reset ] reset ].

	self assert: sols equals: #( #( true false ) )