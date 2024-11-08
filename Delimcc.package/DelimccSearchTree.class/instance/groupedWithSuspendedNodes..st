exploring
groupedWithSuspendedNodes: include

	| l d c |
	d := Dictionary new.
	c := Dictionary new.

	l := self children.

	[ l ] whileNotNil: [
		| assoc |
		assoc := l value.

		assoc key addInVDictionary: d inCDictionary: c weight: assoc value.

		l := l nextLink ].

	d keysAndValuesDo: [ :each :p |
		| node |
		node := DelimccSearchTreeNodeV new
			        slot: each;
			        yourself.

		l := node -> p ~~> l ].

	include ifTrue: [
		c keysAndValuesDo: [ :node :p | l := node -> p ~~> l ] ].

	^ self class new
		  children: l;
		  yourself