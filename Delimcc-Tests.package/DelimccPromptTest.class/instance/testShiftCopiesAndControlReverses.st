tests - derived
testShiftCopiesAndControlReverses

	self assert: (self traverse: #( 1 2 3 4 ) with: #shift:) equals: #( 1 2 3 4 ).
	self assert: (self traverse: #( 1 2 3 4 ) with: #control:) equals: #( 4 3 2 1 )