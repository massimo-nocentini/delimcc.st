printing
printOn: aStream

	aStream << 'V ['.
	self slot printOn: aStream.
	aStream << ']'