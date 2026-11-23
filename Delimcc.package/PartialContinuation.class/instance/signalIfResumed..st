private
signalIfResumed: someContexts
	"someContexts are my contexts, from my top one down its senders, which my first invocation or #unwind is about to take. Signal a DelimccResumedSliceError when something has resumed them since my capture, as the invocation of a Continuation captured inside my delimiter before my capture does, since that Continuation holds the bottom part of them: once the computation that it resumed has left them, the walk ends at a context that has returned, and while that computation still runs them, the walk goes on below my bottom context, whose sender the Continuation has restored. Running them, or making my template from them, would run what that computation has left of them, or a copy of the whole stack below my delimiter, instead of the computation that my capture interrupted.
	Nothing is checked once another invocation has kept my template, since it has run my contexts itself, nor for the copies of callcc, for which I keep no bottom context."

	| last |
	(bottom isNil or: [ template notNil ]) ifTrue: [ ^ self ].
	last := someContexts last.
	(last == bottom and: [ last isDead not ]) ifTrue: [ ^ self ].
	DelimccResumedSliceError new
		continuation: self;
		signal