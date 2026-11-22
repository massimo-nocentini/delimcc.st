tests - debugger
testStepIntoRunsTheCopies

	self probesOfTheDebugger do: [ :each | self assert: (self isolated: [ self stepInto: each second ]) equals: each third ]