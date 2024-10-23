tests - utilities
reify: aBlock
	"(define (reify* t) (resetcc (eta (t))))"

	^ [ self eta: aBlock value ] reset