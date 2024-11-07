exploring
inferenceUpToDepth: maxDepth

	| l ans choices pair |
	pair := self choiceValueLink
		        probability: 1.0
		        depth: 0
		        upToDepth: maxDepth
		        down: true
		        map: nil
		        suspLink: nil.

	l := pair first.
	ans := pair second.

	choices := Dictionary new.

	[ ans ] whileNotNil: [
		l := ans value ~~> l.
		ans := ans nextLink ].

	[ l ] whileNotNil: [
		choices at: l value key put: l value value.
		l := l nextLink ].

	^ self class new
		  children: choices;
		  yourself