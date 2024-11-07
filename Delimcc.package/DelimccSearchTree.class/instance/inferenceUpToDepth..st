exploring
inferenceUpToDepth: maxDepth

	| l ans |
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
			     value: v;
			     yourself.

		l := ValueLink new
			     value: w -> prob;
			     nextLink: l;
			     yourself ].

	^ self class new
		  children: (Dictionary newFromPairs: l asLinkedList);
		  yourself