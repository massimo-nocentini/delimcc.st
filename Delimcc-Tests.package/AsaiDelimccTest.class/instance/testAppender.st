tests
testAppender

	| appender |
	appender := [ self appender: #( 1 2 3 ) asValueLink ] reset.

	self
		assert: (appender ! #( 4 5 6 ) asValueLink) asArray
		equals: #( 1 2 3 4 5 6 )