helpers
returnThroughEnsure

	[ ^ [ :k | (k value: 10) + (k value: 20) ] shift ] ensure: [ log add: #ensure ].
	^ 0