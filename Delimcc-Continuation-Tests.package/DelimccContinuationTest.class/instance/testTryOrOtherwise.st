tests - api
testTryOrOtherwise
	"The otherwise: block gets the newest result first."

	self
		assert: (Continuation
				 try: [ :local | 5 ]
				 or: [ :local :r | 6 ]
				 otherwise: [ :a :b | #else ])
		equals: 5.
	self
		assert: (Continuation
				 try: [ :local | local value: 1 ]
				 or: [ :local :r | 100 + r ]
				 otherwise: [ :a :b | #else ])
		equals: 101.
	self
		assert: (Continuation
				 try: [ :local | local value: 1 ]
				 or: [ :local :r | local value: r + 1 ]
				 otherwise: [ :a :b | { a. b } ])
		equals: #( 2 1 )