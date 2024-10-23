tests
testAmb
	"(⊦= '(1 2 3) (reify (amb 1 2 3)))
                    (⊦= '(8 9 9 10) (reify (+ (amb 1 2) 3 (amb 4 5))))
                    (⊦= '(31 51) (reify (+ 1 (letcc k (* 10 (amb 3 (k 4)))))))"

	| appender |
	appender := [ self appender: #( 1 2 3 ) asValueLink ] reset.

	self
		assert: (appender ! #( 4 5 6 ) asValueLink) asArray
		equals: #( 1 2 3 4 5 6 )