"Check that the examples of the section Semantics of README.md are those that DelimccReadmeTest executes. Run it in an image where Delimcc-Tests is loaded, from the root of the repository, or with DCC_README set to the path of README.md:
  pharo --headless X.image --no-default-preferences st --quit scripts/readme.st
It prints README OK, or README MISMATCH and the examples that differ."
| log readme start end section blocks examples rest |
log := [ :line | Stdio stdout nextPutAll: line asString; lf; flush ].
readme := (OSEnvironment current at: 'DCC_README' ifAbsent: [ 'README.md' ]) asFileReference contents.
start := readme indexOfSubCollection: '## Semantics'.
end := readme indexOfSubCollection: (String with: Character lf) , '## ' startingAt: start + 1.
section := readme copyFrom: start to: (end = 0
		           ifTrue: [ readme size ]
		           ifFalse: [ end - 1 ]).
blocks := OrderedCollection new.
rest := section.
[ (rest indexOfSubCollection: '```smalltalk') > 0 ] whileTrue: [
	| from to |
	from := (rest indexOfSubCollection: '```smalltalk') + '```smalltalk' size + 1.
	to := rest indexOfSubCollection: (String with: Character lf) , '```' startingAt: from.
	blocks add: (rest copyFrom: from to: to - 1) lines.
	rest := rest copyFrom: to + 4 to: rest size ].
examples := DelimccReadmeTest new examples collect: [ :each | each lines ].
blocks asArray = examples asArray
	ifTrue: [ log value: 'README OK ' , blocks size printString , ' examples' ]
	ifFalse: [
		log value: 'README MISMATCH: ' , blocks size printString , ' in README.md, ' , examples size printString , ' in DelimccReadmeTest'.
		1 to: (blocks size max: examples size) do: [ :i |
			(blocks at: i ifAbsent: [ nil ]) = (examples at: i ifAbsent: [ nil ]) ifFalse: [ log value: '  example ' , i printString , ' differs' ] ] ]