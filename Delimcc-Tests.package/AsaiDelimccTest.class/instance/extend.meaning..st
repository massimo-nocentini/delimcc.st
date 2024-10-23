tests - utilities
extend: f meaning: l
	"(define (extend f l) (apply append (map f l)))"

	^ Array streamContents: [ :s |
		  | v |
		  v := l collect: f.

		  s nextPutAll: v ]