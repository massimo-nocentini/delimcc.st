tests - fixes
testEscapeRunsIfCurtailedBlocks

	| r |
	log := OrderedCollection new.
	r := Continuation currentDo: [ :c |
		     k := c.
		     0 ].
	r = 0 ifTrue: [
		[
		k value: 1.
		log add: #afterEscape ] ifCurtailed: [ log add: #curtailed ] ].
	self assert: r equals: 1.
	self assert: log asArray equals: #( #curtailed )