tests
testPrintOnBinaryFileStream
	"Like Stdio stdout, a binary file stream does not understand #space."

	| tree file |
	tree := [ true bernoulli: 1 / 2 ] hansei inferenceExact.
	file := FileReference newTempFilePrefix: 'delimcc' suffix: '.txt'.

	[
	(File named: file fullName) writeStreamDo: [ :aStream |
		tree printOn: aStream ].

	self assert: file contents equals: tree printString ] ensure: [
		file ensureDelete ]