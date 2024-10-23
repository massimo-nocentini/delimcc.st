adding
addDelimccDistribution: aDistribution

	aDistribution keysAndValuesDo: [ :value :occurrences |
		self addObject: value occurrences: occurrences ]