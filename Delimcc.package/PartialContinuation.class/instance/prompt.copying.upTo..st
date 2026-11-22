initialize-release
prompt: aPrompt copying: topContext upTo: aContext
	"I am a copy of the contexts from topContext down to aContext, excluded, which go on running: callcc's continuation. My first invocation makes my template from this copy, with the references to these contexts re-pointed to their copies, and every invocation runs fresh copies of the template, which share the temp vectors of these contexts, as the invocations of a continuation share the variables in Scheme."

	prompt := aPrompt.
	from := self copy: topContext upTo: aContext depth: 0