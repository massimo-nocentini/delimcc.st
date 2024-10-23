tests - utilities
appender: aValueLink

	^ aValueLink ifNil: [ self extractDelimcc ] ifNotNil: [
		  ValueLink new
			  value: aValueLink value;
			  nextLink: (self appender: aValueLink nextLink);
			  yourself ]