helpers - rules
shotsOfAReturnBy: aCopier
	"The top frame runs a block whose home is in the slice, and returns from it with ^."

	| k |
	k := [ self returnOfK + 1 ] reset.
	self copiesOf: k by: aCopier.
	^ {
		  (k value: 1).
		  (k value: 2) }