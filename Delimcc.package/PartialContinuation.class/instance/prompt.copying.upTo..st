initialize-release
prompt: aPrompt copying: topContext upTo: aContext
	"I am a copy of the contexts from topContext down to aContext, excluded, which go on running: callcc's continuation. My first invocation makes my template from this copy, with the references to these contexts re-pointed to their copies, and every invocation runs fresh copies of the template, which share the temp vectors of these contexts, as the invocations of a continuation share the variables in Scheme. When one of these contexts runs an exception handler, I make my template at once instead, since the exception changes as the handler goes on (pass, outer, signal), and the copies must handle it as it is now."

	prompt := aPrompt.
	from := self copy: topContext upTo: aContext depth: 0.
	self runsAHandler ifFalse: [ ^ self ].
	self keepTemplateOfCopies: (self framesFrom: from upTo: nil).
	from := nil