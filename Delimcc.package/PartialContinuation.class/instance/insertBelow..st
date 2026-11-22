private
insertBelow: aContext
	"Stitch the contexts of an invocation between aContext and its sender: aContext returns into the top one, and the bottom one returns to the sender of aContext."

	| frames size |
	frames := self framesForShot.
	(size := frames size) = 0 ifTrue: [ ^ self ].
	(frames at: size) privSender: aContext sender.
	aContext privSender: (frames at: 1)