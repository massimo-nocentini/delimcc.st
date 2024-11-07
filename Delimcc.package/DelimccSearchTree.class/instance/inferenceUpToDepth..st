exploring
inferenceUpToDepth: maxDepth

	| l ans pair |
	pair := self children
		        probability: 1.0
		        depth: 0
		        upToDepth: maxDepth
		        down: true
		        map: nil
		        suspLink: nil.

	l := pair first.
	ans := pair second.

	[ ans ] whileNotNil: [
		l := ans value ~~> l.
		ans := ans nextLink ].

	^ self class new
		  children: l;
		  yourself