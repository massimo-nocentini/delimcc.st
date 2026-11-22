*Delimcc-Continuation-Tests-tests
testMethodTemps

	| i continuation trace |
	trace := OrderedCollection new.
	i := 0.
	i := i + (self callcc: [ :cc |
		      continuation := cc.
		      1 ]).
	trace add: i.
	self assert: i ~= 3.
	i = 2 ifFalse: [ continuation value: 2 ].
	"the second time, the + resumed with the 0 that it had read before the capture"
	self assert: trace asArray equals: #( 1 2 ).
	self assert: i equals: 2