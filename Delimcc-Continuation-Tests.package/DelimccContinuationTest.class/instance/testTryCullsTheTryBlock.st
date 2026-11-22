tests - fixes
testTryCullsTheTryBlock
	"A stock try:otherwise: sent value: to its try block, while try:or:otherwise: culls its blocks."

	self
		assert: (Continuation try: [ 42 ] otherwise: [ :r | #else ])
		equals: 42.
	self
		assert: (Continuation
				 try: [ :local |
					 local value: 3.
					 #notEscaped ]
				 otherwise: [ :r | r * 2 ])
		equals: 6.
	self
		assert: (Continuation try: [ :local | 5 ] otherwise: [ #else ])
		equals: 5