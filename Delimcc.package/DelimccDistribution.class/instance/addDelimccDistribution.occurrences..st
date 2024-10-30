adding - dispatched
addDelimccDistribution: aDistribution occurrences: _

	aDistribution keysAndValuesDo: [ :value :occurrences |
		value addInDelimccDistribution: self occurrences: occurrences ]