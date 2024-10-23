tests
testAmb
	"(⊦= '(1 2 3) (reify (amb 1 2 3)))
                    (⊦= '(8 9 9 10) (reify (+ (amb 1 2) 3 (amb 4 5))))
                    (⊦= '(31 51) (reify (+ 1 (letcc k (* 10 (amb 3 (k 4)))))))

(define (www)
                     (define (f x) (+ x (amb 6 4 2 8) (amb 2 4 5 4 1)))
                     (reify (f (f (amb 0 2 3 4 5 32)))))"

	| res |
	res := self amb: #( 1 2 3 ) in: [ :p | p ].

	self assert: res equals: #( 1 2 3 ).

	res := self
		       amb: #( 1 2 )
		       in: [ :v | self amb: #( 4 5 ) in: [ :w | v + 3 + w ] ].

	self assert: res equals: #( 8 9 9 10 ).

	res := self
		       amb: #( 0 2 3 4 5 32 )
		       in: [ :p | self wwwF: (self wwwF: p) ].

	self assert: res equals: #( 8 9 9 10 )