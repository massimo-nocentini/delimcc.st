initialize-release
prompt: aPrompt from: topContext
	"I am the contexts from topContext down its senders, cut off the stack below the delimiter of aPrompt, or no context when topContext is nil."

	prompt := aPrompt.
	from := topContext.
	topContext ifNil: [ template := DelimccSliceTemplate empty ]