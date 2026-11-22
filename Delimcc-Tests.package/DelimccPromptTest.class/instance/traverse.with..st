helpers
traverse: aCollection with: aSelector
	"Biernacki, Danvy and Shan: visit (x :: xs) = visit (OP (fun k -> x :: k xs)), with OP shift or control."

	| visit |
	visit := nil.
	visit := [ :list |
	         list isEmpty
		         ifTrue: [ #(  ) ]
		         ifFalse: [
			         visit value: (p perform: aSelector with: [ :k | { list first } , (k value: list allButFirst) ]) ] ].
	^ p delimit: [ visit value: aCollection asArray ]