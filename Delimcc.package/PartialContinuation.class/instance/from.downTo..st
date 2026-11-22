initialize-release
from: topContext downTo: bottomContext
	"I am a copy of the contexts from topContext down to bottomContext, excluded, which may go on running, delimited by the prompt of #reset: the constructor of the PartialContinuation of old, which callcc makes with #prompt:copying:upTo: now."

	self prompt: DelimccPrompt reset copying: topContext upTo: bottomContext