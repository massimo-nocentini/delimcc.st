tests
testPrintOnBinaryFileStreamWithCollections
	"The values print themselves on a String: an Array, for example, sends #space to its stream, which a binary file stream does not understand."

	| tree file |
	tree := [ { true bernoulli: 1 / 2. #a } ] hansei inferenceExact.
	file := FileReference newTempFilePrefix: 'delimcc' suffix: '.txt'.

	[
	(File named: file fullName) writeStreamDo: [ :aStream |
		tree printOn: aStream ].

	self assert: file contents equals: tree printString ] ensure: [
		file ensureDelete ]