printing
printOn: aStream

	aStream
		<< 'a search tree with ';
		<< self children size asString;
		<< ' children: '.

	(self groupedWithSuspendedNodes: false) children do: [ :each |
		each printOn: aStream.
		aStream << ', ' ]