printing
printOn: aStream

	| pair |
	pair := self asValuesDictionaryNormalized: true.

	aStream << 'a SearchTree(values distribution {'.

	pair first keysAndValuesDo: [ :each :p |
		aStream
			space;
			<< '('.

		each printOn: aStream.
		aStream
			<< ' ~ ';
			<< (p printShowingDecimalPlaces: 3);
			<< ')' ].

	aStream << ' }, '.

	pair second size printOn: aStream.

	aStream << ' branches left)'