helpers
isolated: aBlock
	"Answer what aBlock answers in a process of its own, or the error that ends that process. The copy of a slice can leave through contexts that no handler of the caller sees (review #2), so the error handler of the process catches the error there."

	| process |
	isolation := Semaphore new.
	process := [
	           outcome := [ aBlock value ] on: Error do: [ :e | e ].
	           isolation signal ] newProcess.
	process errorHandler: self.
	process resume.
	(isolation waitTimeoutSeconds: 10) ifTrue: [
		process terminate.
		^ #timeout ].
	^ outcome