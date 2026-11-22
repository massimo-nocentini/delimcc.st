tests - fixes
testEscapeUnwindsTheFramesBelowARewiredSender
	"Generator>>#next makes the home context of the generator return to the caller of next, so during the second next the producer's frames sit on the consumer's ensure: frame. k, captured in the producer while the generator was created, is invoked there. The ensure: frame lies below frames that the two stacks share, but k's stack does not hold it: the invocation abandons it, so its block runs. Unwinding only the frames above the topmost shared frame left it out, and stock ran no unwind block at all."

	| generator r |
	log := OrderedCollection new.
	count := 0.
	r := Continuation currentDo: [ :c |
		     tmp := c.
		     #start ].
	r == #start ifTrue: [
		generator := Generator on: [ :g |
			             | v |
			             v := Continuation currentDo: [ :c |
				                  k := c.
				                  0 ].
			             log add: { #producerGot. v }.
			             v = 5 ifTrue: [ tmp value: #reentered ].
			             [
			             g yield: v.
			             count := count + 1.
			             count = 2 ifTrue: [ k value: 5 ] ] repeat ].
		log add: { #first. generator next }.
		[ log add: { #second. generator next } ] ensure: [
			log add: #consumerEnsure ].
		log add: #afterSecond ].
	self assert: r equals: #reentered.
	self
		assert: log asArray
		equals: {
				{ #producerGot. 0 }.
				{ #first. 0 }.
				#consumerEnsure.
				{ #producerGot. 5 } }