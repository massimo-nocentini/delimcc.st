tests - callcc
testCallCCInAHandlerThatGoesOuter
	"callcc in a handler that then sends outer to its exception, which the outer handler resumes: each re-entry resumes the copy of outer (review-semantics 4)."

	| n |
	n := 0.
	self
		assert: (self isolated: [
				 [
				 [
				 | kc r |
				 r := [ [ Warning signal: 'w' ] on: Warning do: [ :e |
					       [ :k | kc := k ] callcc.
					       e outer + 1 ] ]
					      on: Warning
					      do: [ :e | e resume: 5 ].
				 n := n + 1.
				 n < 3 ifTrue: [ kc value: 0 ].
				 {
					 r.
					 n } ] reset ]
					 on: Warning
					 do: [ :e | e resume: 100 ] ])
		equals: #( 6 3 )