tests - fixes
testEscapeRunsEachUnwindBlockOnceFromTheTopDown
	"The escape runs the unwind blocks of the frames it abandons, the innermost first; the ensure: block around the capture is below the shared frame, so it runs once, when its block returns."

	| r |
	log := OrderedCollection new.
	[
	r := Continuation currentDo: [ :c |
		     k := c.
		     0 ].
	r = 0 ifTrue: [
		[ [ k value: 1 ] ensure: [ log add: #inner ] ] ensure: [
			log add: #outer ] ].
	log add: { #resumed. r } ] ensure: [ log add: #around ].
	self
		assert: log asArray
		equals: {
				#inner.
				#outer.
				{ #resumed. 1 }.
				#around }