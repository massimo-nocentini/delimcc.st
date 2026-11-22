testing
testDrefIgnoresGenericHandlers
	| p |
	p := DelimitedDynamicVariable default: #uninitialized.
	self assert: (p dlet: 1 in: [ [ p dref ] on: Exception do: [ :e | e return: #caught ] ]) equals: 1.
	self assert: (p dlet: 1 in: [ [ p dset: 2. p dref ] on: Notification do: [ :e | e resume: 5 ] ]) equals: 2.
	self assert: ([ p dref ] on: Notification do: [ :e | e resume: 5 ]) equals: #uninitialized