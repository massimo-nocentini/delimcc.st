tests - basics
testPromptPrintsItsName

	self assert: p printString equals: 'a DelimccPrompt(p)'.
	self assert: DelimccPrompt new printString equals: 'a DelimccPrompt'