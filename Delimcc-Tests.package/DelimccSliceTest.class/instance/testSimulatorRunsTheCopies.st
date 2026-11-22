tests - debugger
testSimulatorRunsTheCopies
	"The simulator of Context, with which the debugger steps, gives the answers of the VM."

	self probesOfTheDebugger do: [ :each | self assert: (self isolated: [ Context runSimulated: each second ]) equals: each third ]