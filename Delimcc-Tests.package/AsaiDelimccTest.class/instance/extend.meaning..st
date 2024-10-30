tests - utilities
extend: f meaning: l
	"(define (extend f l) (apply append (map f l)))"

	^ Array streamContents: [ :s |
		  l collect: f thenDo: [ :each | s nextPutAll: each ] ]