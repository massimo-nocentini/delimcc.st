tests
testDictionaryCollectShift
	| d |
	d := Dictionary new
		     at: 1 put: 10;
		     at: 2 put: 20;
		     yourself.
	self
		assert: [ d collectShift + 1 ] reset
		equals: (Dictionary new at: 1 put: 11; at: 2 put: 21; yourself).
	self
		assert: [ (d collectShift: [ :key :value | key + value ]) * 2 ] reset
		equals: (Dictionary new at: 1 put: 22; at: 2 put: 44; yourself)