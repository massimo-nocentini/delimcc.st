enumerating
copy: fromContext to: aContext bottomContextDo: aBlock
	"Copy self and my sender chain down to, but not including, aContext.  
	End of copied chain will have nil sender. Evaluate aBlock with the copy 
	of bottom context when it still points to the original sender."

	^ fromContext == aContext
		  ifTrue: [ nil ]
		  ifFalse: [
			  | copy |
			  copy := fromContext copy.

			  fromContext sender
				  ifNil: [ aBlock value: copy ]
				  ifNotNil: [ :s |
					  s == aContext ifTrue: [ aBlock value: copy ].
					  copy privSender:
						  (self copy: s to: aContext bottomContextDo: aBlock) ].

			  copy ]