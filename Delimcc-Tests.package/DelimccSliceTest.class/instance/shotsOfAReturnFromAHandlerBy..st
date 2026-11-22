helpers - rules
shotsOfAReturnFromAHandlerBy: aCopier
	"e return: returns from the handler context of the exception."

	| k |
	k := [ [ (Warning signal: 'w') + 0 ] on: Warning do: [ :e | e return: [ :kk | kk ] shift ] ] reset.
	self copiesOf: k by: aCopier.
	^ {
		  (k value: 1).
		  (k value: 2) }