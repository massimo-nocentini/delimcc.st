tests - scanner
testTempVectorScannerCachesManyCodes
	"The cache of the scanner answers as a scan does, and costs about as much, however many CompiledCodes it has met: a miss changes one entry."

	| codes answers scans cached |
	codes := (Object withAllSubclasses
		          inject: OrderedCollection new
		          into: [ :all :each |
			          all size < 20000 ifTrue: [ all addAll: each methods ].
			          all ]) asArray.
	scans := Time millisecondsToRun: [ answers := codes collect: [ :each | DelimccTempVectorScanner new scan: each ] ].
	cached := Time millisecondsToRun: [
		          self assert: (codes collect: [ :each | DelimccTempVectorScanner vectorSlotsOf: each ]) equals: answers ].
	self assert: cached < (scans * 5 + 500)