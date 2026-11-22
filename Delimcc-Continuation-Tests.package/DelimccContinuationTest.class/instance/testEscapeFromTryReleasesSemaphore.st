tests - fixes
testEscapeFromTryReleasesSemaphore

	| semaphore result |
	semaphore := Semaphore forMutualExclusion.
	result := Continuation
		          try: [ :local |
			          semaphore critical: [ local value: 7 ].
			          #notEscaped ]
		          otherwise: [ :r | r ].
	self assert: result equals: 7.
	self deny: (semaphore waitTimeoutMilliseconds: 200).
	semaphore signal