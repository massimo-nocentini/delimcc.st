private
insertBelow: aContext
	"Stitch the contexts of an invocation between aContext and its sender: aContext returns into the top one, and the bottom one returns to the sender of aContext."

	| frames |
	frames := self framesForShot.
	frames isEmpty ifTrue: [ ^ self ].
	frames last privSender: aContext sender.
	aContext privSender: frames first