tests - utilities
reify: aBlock
	"(define (reify* t) (resetcc (eta (t))))"

	^ [ :k | self eta: aBlock value ] reset