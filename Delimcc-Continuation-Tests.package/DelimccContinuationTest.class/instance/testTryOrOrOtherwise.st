tests - api
testTryOrOrOtherwise
	"The second or: block gets the result of the first one, not the one of the try block; the otherwise: block gets the newest result first."

	self
		assert: (Continuation
				 try: [ :local | local value: 1 ]
				 or: [ :local :r | local value: 5 ]
				 or: [ :local :r | r * 3 ]
				 otherwise: [ :a :b :c | #else ])
		equals: 15.
	self
		assert: (Continuation
				 try: [ :local | local value: 1 ]
				 or: [ :local :r | local value: r + 1 ]
				 or: [ :local :r | local value: r * 10 ]
				 otherwise: [ :a :b :c | { a. b. c } ])
		equals: #( 20 2 1 )