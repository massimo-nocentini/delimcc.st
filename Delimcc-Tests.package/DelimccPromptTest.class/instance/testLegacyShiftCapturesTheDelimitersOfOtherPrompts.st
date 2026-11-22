tests - tags
testLegacyShiftCapturesTheDelimitersOfOtherPrompts

	self assert: [ 1 + (p delimit: [ 10 + [ :k | k value: (k value: 100) ] shift ]) ] reset equals: 122.
	self deny: [ p delimit: [ [ :k | p isDelimiting ] shift ] ] reset.
	self assert: [ p delimit: [ [ :k | k value: 0 ] shift. p isDelimiting ] ] reset