exploring
inferenceUpToDepth: maxDepth

	| l ans choices pair |
	pair := self
		        probability: 1.0
		        depth: 0
		        upToDepth: maxDepth
		        down: true
		        choices: self choiceValueLink
		        map: nil
		        suspLink: nil.

	l := pair first.
	ans := pair second.

	choices := Dictionary new.

	[ ans ] whileNotNil: [
		l := ValueLink new
			     value: ans value;
			     nextLink: l;
			     yourself.

		ans := ans nextLink ].

	[ l ] whileNotNil: [
		| v |
		v := choices at: l value key ifAbsentPut: 0.0.
		choices at: l value key put: l value value + v.
		l := l nextLink ].

	^ self class new
		  children: choices;
		  yourself