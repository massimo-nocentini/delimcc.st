instance creation
templateOf: anArray
	"Answer a template of the contexts of anArray, top first, the bottom one with no sender, as they are now. A slice of 16 contexts or fewer, as most of Hansei are, is fixed at once: that costs less than a snapshot when it is invoked twice. A deeper one gets a DelimccSliceSnapshot, which costs about one plain copy and is fixed at its first #instantiate, so that a continuation invoked once, as that of a generator, never pays for me."

	anArray size <= 16 ifTrue: [ ^ self new templateOf: anArray ].
	^ DelimccSliceSnapshot of: anArray