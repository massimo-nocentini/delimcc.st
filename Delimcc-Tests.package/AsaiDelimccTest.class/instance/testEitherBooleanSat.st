tests
testEitherBooleanSat
	"(⊦= '(((p #t) (q #f))) 
           (let1 (sols '())
            (resetcc
                      (let ((p (delimcc-either '(#t #f)))
                            (q (delimcc-either '(#t #f))))
                       (when (and (or p q) (or p (not q)) (or (not p) (not q)))
                        (push! `((p ,p) (q ,q)) sols))))
            sols))"

	| sols choices |
	choices := { true. false }.
	sols := OrderedCollection new.

	self
		assert: [
			| p q |
			p := self delimccEither: choices.
			q := self delimccEither: choices ] reset asArray
		equals: #( 1 4 3 )