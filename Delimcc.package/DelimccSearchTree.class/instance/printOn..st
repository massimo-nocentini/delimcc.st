printing
printOn: aStream

	aStream
		<< 'a search tree with ';
		<< self children size asString;
		<< ' children'