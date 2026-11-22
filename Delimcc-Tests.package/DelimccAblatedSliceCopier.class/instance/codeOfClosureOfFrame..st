codes
codeOfClosureOfFrame: aClosureOrNil

	^ rule == #closureOrNil
		  ifTrue: [ 0 ]
		  ifFalse: [ super codeOfClosureOfFrame: aClosureOrNil ]