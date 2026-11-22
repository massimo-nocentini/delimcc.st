tests - debugger
testStepOverACapture
	"Over a capture, the debugger inserts contexts below it that jump back to the debugger when the capture returns: they are in k, so the first invocation returns through them, and the copies leave them out."

	self assert: (self isolated: [ self stepOver: #shift in: [ 1 + [ 10 + ([ :k | (k value: 100) * 2 ] shift) ] reset ] ]) equals: 221.
	self probesOfTheDebugger do: [ :each | self assert: (self isolated: [ self stepOver: each first in: each second ]) equals: each third ]