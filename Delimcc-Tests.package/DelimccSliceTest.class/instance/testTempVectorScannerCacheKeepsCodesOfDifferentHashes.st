tests - scanner
testTempVectorScannerCacheKeepsCodesOfDifferentHashes
	"The cache of the scanner keeps the answers for codes whose basic identity hashes differ in their low 12 bits, which #identityHash shifts out: indexed by it, the 4096 entries were 16, and the codes of a slice evicted each other, so that each first invocation scanned them again (review-perf 1)."

	| codes hashes entries |
	codes := OrderedCollection new.
	hashes := Set new.
	Object methods do: [ :each |
		| hash |
		hash := each basicIdentityHash bitAnd: 4095.
		(codes size < 64 and: [ (hashes includes: hash) not ]) ifTrue: [
			hashes add: hash.
			codes add: each ] ].
	codes do: [ :each | DelimccTempVectorScanner vectorSlotsOf: each ].
	entries := (DelimccTempVectorScanner classPool at: #Entries) select: [ :each | each notNil ].
	self assert: (codes count: [ :code | entries anySatisfy: [ :each | each key == code ] ]) equals: codes size