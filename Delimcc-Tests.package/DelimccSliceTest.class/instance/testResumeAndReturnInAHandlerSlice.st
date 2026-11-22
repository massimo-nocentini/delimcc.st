tests - review 2
testResumeAndReturnInAHandlerSlice

	self
		assert: (self isolated: [ [ [ (Warning signal: 'w') + 0 ] on: Warning do: [ :e | e resume: ([ :k | (k value: 1) + (k value: 2) ] shift) ] ] reset ])
		equals: 3.
	self
		assert: (self isolated: [ [ [ (Warning signal: 'w') + 0 ] on: Warning do: [ :e | e return: ([ :k | (k value: 1) + (k value: 2) ] shift) ] ] reset ])
		equals: 3