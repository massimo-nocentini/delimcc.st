*Delimcc
? aBlock

	| distribution |
	distribution := DelimccDistribution new.

	[ self either: aBlock distribution: distribution ] reset.

	^ distribution