testing - controlling
testDrefIgnoresGenericHandlers
	| d p |
	d := DelimitedDynamicVariable default: 0.
	p := DelimitedDynamicVariable default: 0.
	d, p dlet: #(1 2) in: [
		self assert: 1 equals: ([ d dref ] on: Exception do: [ :e | e return: #caught ]).
		self assert: 2 equals: ([ p dref ] on: Notification do: [ :e | e resume: 5 ]) ]