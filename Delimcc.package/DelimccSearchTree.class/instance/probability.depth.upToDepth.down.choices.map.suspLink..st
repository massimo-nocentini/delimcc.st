exploring
probability: p depth: depth upToDepth: maxDepth down: down choices: choicesLink map: ans suspLink: susp

	| l |
	l := choicesLink ifNil: [ susp ] ifNotNil: [
		     | node pt rest |
		     node := choicesLink value key.
		     pt := choicesLink value value.
		     rest := choicesLink nextLink.

		     node
			     localProbability: pt
			     tree: self
			     probability: p
			     depth: depth
			     upToDepth: maxDepth
			     down: down
			     choices: choicesLink
			     map: ans
			     suspLink: susp ].

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
		  children: l asLinkedList;
		  yourself