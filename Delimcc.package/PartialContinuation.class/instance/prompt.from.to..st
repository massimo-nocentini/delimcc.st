initialize-release
prompt: aPrompt from: topContext to: bottomContext
	"I am the contexts from topContext down to bottomContext, which a capture cut off the stack below the delimiter of aPrompt, so bottomContext has no sender. My first invocation checks that they still end there (#signalIfResumed:)."

	self prompt: aPrompt from: topContext.
	bottom := bottomContext