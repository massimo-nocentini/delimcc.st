running
setUp

	super setUp.
	p := DelimccPrompt named: 'p'.
	q := DelimccPrompt named: 'q'.
	log := OrderedCollection new