tests - utilities
reflect: meaning
	"(define (reflect meaning) (letshiftcc k (extend k meaning)))"

	^ [ :k | self extend: k meaning: meaning ] shift