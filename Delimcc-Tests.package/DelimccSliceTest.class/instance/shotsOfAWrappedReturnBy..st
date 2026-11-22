helpers - rules
shotsOfAWrappedReturnBy: aCopier

	| k |
	k := [ self returnThroughAWrapperOfK ] reset.
	self copiesOf: k by: aCopier.
	^ {
		  (k value: 1).
		  (k value: 2) }