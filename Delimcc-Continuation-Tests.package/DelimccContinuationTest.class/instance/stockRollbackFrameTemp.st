helpers
stockRollbackFrameTemp
	"#rollbackFrameTemp with a continuation in the stock layout."

	| n r |
	n := 0.
	shots := 0.
	r := self stockContinuationFrom: thisContext.
	n := n + 1.
	shots := shots + 1.
	(n < 3 and: [ shots < 3 ]) ifTrue: [ r value: r ].
	^ n