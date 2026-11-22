helpers - rules
shotsOfAHandlerSliceBy: aCopier
	"The frames of the handler have the on:do: context, and the on:do: frame a closure of the slice, as receivers."

	| k |
	k := [ ([ 1 / 0 ] on: ZeroDivide do: [ :e | [ :kk | kk ] shift ]) * 10 ] reset.
	self copiesOf: k by: aCopier.
	^ {
		  (k value: 1).
		  (k value: 2) }