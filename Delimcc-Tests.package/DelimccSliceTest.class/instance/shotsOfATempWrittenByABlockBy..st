helpers - rules
shotsOfATempWrittenByABlockBy: aCopier

	| k |
	k := [
	     | x |
	     x := 0.
	     [ :kk | kk ] shift.
	     [ x := x + 1 ] value.
	     x ] reset.
	self copiesOf: k by: aCopier.
	^ {
		  (k value: nil).
		  (k value: nil) }