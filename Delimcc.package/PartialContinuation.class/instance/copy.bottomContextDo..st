enumerating
copy: fromContext bottomContextDo: aBlock
	"Copy self and my sender chain down to, but not including, aContext.  
	End of copied chain will have nil sender. Evaluate aBlock with the copy 
	of bottom context when it still points to the original sender."

	^ fromContext ifNil: [ nil ] ifNotNil: [
		  | copy |
		  copy := fromContext copy.

		  fromContext sender ifNil: [ aBlock value: copy ] ifNotNil: [ :s |
			  | scopy |
			  scopy := self copy: s bottomContextDo: aBlock.
			  copy privSender: scopy ].

		  copy ]