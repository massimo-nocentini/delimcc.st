tests
testExtract

	| f kk |
	f := [ 3 + [ :k | k ] shift - 1 ] reset.
	kk := [ :x | 3 + x - 1 ].

	self assert: f ! 10 equals: kk ! 10.

	f := [ 3 + self extractDelimcc - 1 ] reset.
	self assert: f ! 10 equals: kk ! 10