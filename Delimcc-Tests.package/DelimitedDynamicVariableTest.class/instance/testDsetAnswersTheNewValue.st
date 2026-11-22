testing
testDsetAnswersTheNewValue
	| p |
	p := DelimitedDynamicVariable default: #default.
	self assert: #(#x 7) equals: { p dset: #x. p dlet: 3 in: [ p dset: 7 ] }