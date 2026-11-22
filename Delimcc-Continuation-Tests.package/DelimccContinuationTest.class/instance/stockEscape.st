helpers
stockEscape
	"Escape with a continuation in the stock layout through an ensure: block."

	| r |
	r := self stockContinuationFrom: thisContext.
	r isNumber ifTrue: [ ^ r ].
	[ self depth: 10 do: [ r value: 42 ] ] ensure: [ log add: #ensure ].
	^ #notReached