exploring
meanFoldr: aBlock init: init

	| mean |
	mean := init.

	self mean keysAndValuesDo: [ :k :v |
		mean := aBlock value: k value: v value: mean ].

	^ mean