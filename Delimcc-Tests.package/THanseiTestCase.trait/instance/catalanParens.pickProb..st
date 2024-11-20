recurrence - catalan parens
catalanParens: emptyProb pickProb: pickProb

	| s |
	s := (true bernoulli: emptyProb)
		     ifTrue: [ '' ]
		     ifFalse: [
			     | sub |
			     sub := self catalanParens: emptyProb pickProb: pickProb.

			     (true bernoulli: pickProb)
				     ifTrue: [
					     String streamContents: [ :aStream |
						     aStream
							     << '(';
							     << sub;
							     << ')' ] ]
				     ifFalse: [
					     String streamContents: [ :aStream |
						     aStream
							     << '(';
							     << ')';
							     << sub ] ] ].

	^ { s } chooseShift