private
insertCopyBelow: aContext
	"Stitch a copy of my contexts between aContext and its sender: aContext returns into the copy of my top context, and the copy of my bottom context returns to the sender of aContext."

	| top bottom |
	top := self context ifNil: [ ^ self ].
	bottom := top.
	[ bottom sender isNil ] whileFalse: [ bottom := bottom sender ].
	bottom privSender: aContext sender.
	aContext privSender: top