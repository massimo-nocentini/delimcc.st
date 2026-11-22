helpers
legacyShift: aBlock
	"BlockClosure>>#shift as it was before the prompts (4730cf3), written with PartialContinuation>>#from:downTo:."

	| delimiter k |
	delimiter := DelimccPrompt reset delimiterFrom: thisContext sender.
	k := PartialContinuation new
		     from: thisContext sender downTo: delimiter sender;
		     yourself.
	thisContext swapSender: delimiter sender.
	^ aBlock value: k