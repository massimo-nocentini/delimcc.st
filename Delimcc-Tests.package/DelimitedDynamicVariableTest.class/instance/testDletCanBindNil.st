testing
testDletCanBindNil
	| p |
	p := DelimitedDynamicVariable default: #default.
	self assert: (p dlet: nil in: [ p dref ]) isNil.
	self assert: (p dlet: 5 in: [ p dset: nil. p dref ]) isNil.
	self assert: #default equals: p default