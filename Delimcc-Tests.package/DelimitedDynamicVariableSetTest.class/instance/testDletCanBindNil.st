testing - controlling
testDletCanBindNil
	| d p |
	d := DelimitedDynamicVariable default: 0.
	p := DelimitedDynamicVariable default: 0.
	d, p dlet: #(nil 1) in: [
		self assert: d dref isNil.
		self assert: 1 equals: p dref ]