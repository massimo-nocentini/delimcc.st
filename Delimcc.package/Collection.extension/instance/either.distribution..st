*Delimcc
either: aBlock distribution: distribution

	| v |
	v := aBlock ! [ :k | self collect: k ] shift.
	v addInDelimccDistribution: distribution occurrences: 1