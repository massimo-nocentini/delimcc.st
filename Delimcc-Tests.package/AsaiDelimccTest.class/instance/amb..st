tests - utilities
amb: aCollection
	"(define-syntax amb (syntax-rules () ((amb v ...) (reflect (append (reify v) ...)))))"

	| meaning |
	meaning := Array streamContents: [ :s |
		           s nextPutAll:
			           (aCollection collect: [ :each | self reify: [ each ] ]) ].

	^ self reflect: meaning