helpers
walk: aTree yield: aBlock

	aTree isArray
		ifTrue: [ aTree do: [ :each | self walk: each yield: aBlock ] ]
		ifFalse: [
			log add: aTree.
			aBlock value: aTree ]