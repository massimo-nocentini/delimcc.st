*Delimcc
copyTo: aContext bottomContextDo: aBlock
	"Copy self and my sender chain down to, but not including, aContext.  
	End of copied chain will have nil sender. Evaluate aBlock with the copy 
	of bottom context when it still points to the original sender."

	^ self == aContext
		  ifTrue: [ nil ]
		  ifFalse: [
			  | copy |
			  copy := self copy.

			  self sender ifNil: [ aBlock value: copy ] ifNotNil: [ :s |
				  s == aContext ifTrue: [ aBlock value: copy ].
				  copy privSender: (s copyTo: aContext bottomContextDo: aBlock) ].

			  copy ]