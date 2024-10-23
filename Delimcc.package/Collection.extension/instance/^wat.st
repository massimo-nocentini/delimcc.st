*Delimcc
? aBlock

	| distribution |
	distribution := DelimccDistribution new.
	[ distribution add: aBlock ! [ :k | self collect: k ] shift ] reset.
	^ distribution