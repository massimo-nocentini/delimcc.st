tests - machine
testUnderTheSimulator
	"The debugger steps with the simulator of Context, which must give the same answers."

	self
		assert: (Context runSimulated: [ 1 + (p delimit: [ 10 + (p shift: [ :k | k value: (k value: 100) ]) ]) ])
		equals: 121.
	self assert: (Context runSimulated: [ self traverse: #( 1 2 3 ) with: #control: ]) equals: #( 3 2 1 ).
	self assert: (Context runSimulated: [ self sameFringe: #( 1 #( 2 3 ) ) and: #( #( 1 2 ) 3 ) ]).
	self assert: (Context runSimulated: [ [ 1 + [ :k | k value: (k value: 2) ] shift ] reset ]) equals: 4