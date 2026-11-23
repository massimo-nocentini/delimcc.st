tests - limits
testContextsResumedBeforeTheFirstInvocation
	"A Continuation captured inside the reset before the shift holds the bottom part of the contexts of k, the reset block here, and invoking it before the first invocation of k resumes them. Then the first invocation of k, and every later one, signals DelimccResumedSliceError instead of running what the re-entry has left of them, or a copy of them: once the re-entry has returned, and also while it still runs them, where k made its template from the whole stack below the reset and looped. A k invoked before the re-entry has kept its template of its own contexts, so the re-entry changes nothing for it.
	entered and first are in a temp vector, which the re-entry does not restore."

	| cont k entered first |
	entered := false.
	self
		assert: (self isolated: [
				 | r |
				 r := [
				      | x |
				      x := Continuation currentDo: [ :c |
					           cont := c.
					           0 ].
				      x = 0
					      ifTrue: [
						      10 + ([ :kk |
							       k := kk.
							       #captured ] shift) ]
					      ifFalse: [ 100 + x ] ] reset.
				 entered ifFalse: [
					 entered := true.
					 cont value: 1 ].
				 r ])
		equals: 101.
	self assert: ((self isolated: [ k value: 5 ]) isKindOf: DelimccResumedSliceError).
	self assert: ((self isolated: [ k value: 6 ]) isKindOf: DelimccResumedSliceError).
	entered := false.
	self
		assert: (self isolated: [
				 | r |
				 r := [
				      | x |
				      x := Continuation currentDo: [ :c |
					           cont := c.
					           0 ].
				      x = 0
					      ifTrue: [
						      10 + ([ :kk |
							       k := kk.
							       #captured ] shift) ]
					      ifFalse: [
						      [ k value: 5 ]
							      on: DelimccResumedSliceError
							      do: [ :e | e return: #resumed ] ] ] reset.
				 entered ifFalse: [
					 entered := true.
					 cont value: 1 ].
				 r ])
		equals: #resumed.
	entered := false.
	self
		assert: (self isolated: [
				 | r |
				 r := [
				      | x |
				      x := Continuation currentDo: [ :c |
					           cont := c.
					           0 ].
				      x = 0
					      ifTrue: [
						      10 + ([ :kk |
							       k := kk.
							       #captured ] shift) ]
					      ifFalse: [ 100 + x ] ] reset.
				 entered ifFalse: [
					 entered := true.
					 first := k value: 5.
					 cont value: 1 ].
				 {
					 first.
					 r.
					 (k value: 6) } ])
		equals: #( 15 101 16 )