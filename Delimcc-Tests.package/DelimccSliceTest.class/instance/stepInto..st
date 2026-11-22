helpers - debugger
stepInto: aBlock
	"Step a process that evaluates aBlock into every send, as the Into of the debugger does, and answer what aBlock answers."

	| result process |
	result := #unfinished.
	process := [ result := aBlock value ] newProcess.
	self stepToTheEnd: process.
	^ result