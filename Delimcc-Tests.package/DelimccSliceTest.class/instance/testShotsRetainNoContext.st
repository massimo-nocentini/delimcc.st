tests - structure
testShotsRetainNoContext
	"1000 invocations of a 50-level k retain its template, not the contexts of the invocations."

	| before k |
	Smalltalk garbageCollect.
	before := Context allInstances size.
	k := [ self deep: 50 ] reset.
	1 to: 1000 do: [ :i | k value: i ].
	Smalltalk garbageCollect.
	self assert: Context allInstances size - before < 200.
	self assert: (k value: 1) equals: 51