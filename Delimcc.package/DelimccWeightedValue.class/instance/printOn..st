printing
printOn: aStream

	self object printOn: aStream.
	aStream
		<< ' ~ ';
		<< (self weight printShowingDecimalPlaces: 4)