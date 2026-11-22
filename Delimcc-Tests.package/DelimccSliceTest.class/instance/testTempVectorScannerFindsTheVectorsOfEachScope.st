tests - scanner
testTempVectorScannerFindsTheVectorsOfEachScope

	| method |
	self assert: (DelimccTempVectorScanner vectorSlotsOf: self class >> #withNoTempVector) equals: #(  ).
	self assert: (DelimccTempVectorScanner vectorSlotsOf: self class >> #withOneTempVector) equals: #( 2 ).
	method := self class >> #withThreeTempVectors.
	self assert: (DelimccTempVectorScanner vectorSlotsOf: method) equals: #( 1 ).
	self
		assert: (method allBlocks asArray collect: [ :each | (DelimccTempVectorScanner vectorSlotsOf: each) size ]) asBag
		equals: #( 0 1 1 ) asBag