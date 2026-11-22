instance creation
copiesOf: anArray
	"Answer copies of the contexts of anArray, top first, chained as they are, the bottom one with no sender (R1)."

	| copies below |
	copies := Array new: anArray size.
	below := nil.
	anArray size to: 1 by: -1 do: [ :i |
		below := copies at: i put: ((anArray at: i) shallowCopy
				          privSender: below;
				          yourself) ].
	^ copies