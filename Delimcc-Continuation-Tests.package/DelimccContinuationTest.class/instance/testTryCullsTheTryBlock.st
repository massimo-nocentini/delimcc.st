tests - fixes
testTryCullsTheTryBlock
	"A stock try:otherwise: sent value: to its try block. try:or:otherwise: and try:or:or:otherwise: pass their try block to it, so all three raised ArgumentsCountMismatch for a try block with no argument."

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
		equals: 5.
	self
		assert: (Continuation
				 try: [ 42 ]
				 or: [ :local | #or ]
				 otherwise: [ :r :res | #else ])
		equals: 42.
	self
		assert: (Continuation
				 try: [ 42 ]
				 or: [ :local | #or ]
				 or: [ :local | #orr ]
				 otherwise: [ :rr :r :res | #else ])
		equals: 42