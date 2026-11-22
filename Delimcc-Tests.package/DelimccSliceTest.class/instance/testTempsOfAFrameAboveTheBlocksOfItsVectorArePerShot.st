tests - temps
testTempsOfAFrameAboveTheBlocksOfItsVectorArePerShot
	"The block c runs below the frame of the block that declares x, which k1 runs above it: k2 holds the frame that owns the temp vector of x above a frame that refers to it, and each invocation has its own x, which both frames share."

	| p q c k1 k2 |
	p := DelimccPrompt named: 'p'.
	q := DelimccPrompt named: 'q'.
	q delimit: [
		| x |
		x := 0.
		c := [
		     x := x + 10.
		     k1 value: nil.
		     x := x + 100.
		     x ].
		q shift0: [ :k |
			k1 := k.
			#first ].
		p shift0: [ :k |
			k2 := k.
			#captured ].
		x := x + 1.
		x ].
	self assert: (p delimit: [ c value ]) equals: #captured.
	self assert: (self isolated: [ (1 to: 3) collect: [ :i | k2 value: nil ] ]) equals: #( 111 111 111 )