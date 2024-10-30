tests - utilities
amb: aCollection in: block
	"(define-syntax amb (syntax-rules () ((amb v ...) (reflect (append (reify v) ...)))))"

	^ [
	  | meaning |
	  meaning := Array streamContents: [ :s |
		             aCollection
			             collect: [ :each | self reify: [ each ] ]
			             thenDo: [ :each | s nextPut: each ] ].

	  block ! (self reflect: meaning) ] reset