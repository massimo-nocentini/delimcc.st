exploring
inferenceUpToDepth: maxDepth

	| l ans choices |
	ans := Dictionary new.

	l := self
		     probability: 1.0
		     depth: 0
		     upToDepth: maxDepth
		     down: true
		     choices: self choiceValueLink
		     map: ans
		     suspLink: nil.

	ans keysAndValuesDo: [ :v :prob |
		| w |
		w := DelimccSearchTreeNodeV new
			     slot: v;
			     yourself.

		l := ValueLink new
			     value: w -> prob;
			     nextLink: l;
			     yourself ].

	choices := Dictionary new.

	[ l ] whileNotNil: [
		choices at: l value key put: l value value.
		l := l nextLink ].

	^ self class new
		  children: choices;
		  yourself