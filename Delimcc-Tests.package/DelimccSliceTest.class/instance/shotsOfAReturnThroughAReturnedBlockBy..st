helpers - rules
shotsOfAReturnThroughAReturnedBlockBy: aCopier

	| k |
	k := [ self returnThroughAReturnedBlockOfK ] reset.
	self copiesOf: k by: aCopier.
	^ {
		  (k value: 1).
		  (k value: 2) }