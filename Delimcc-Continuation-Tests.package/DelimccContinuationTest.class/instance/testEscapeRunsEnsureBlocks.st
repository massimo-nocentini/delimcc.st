tests - fixes
testEscapeRunsEnsureBlocks

	| r |
	log := OrderedCollection new.
	r := Continuation currentDo: [ :c |
		     k := c.
		     0 ].
	r = 0 ifTrue: [
		[
		k value: 1.
		log add: #afterEscape ] ensure: [ log add: #ensure ] ].
	self assert: r equals: 1.
	self assert: log asArray equals: #( #ensure )