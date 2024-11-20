*Delimcc
asResetArray

	^ Array streamContents: [ :s | [ s nextPut: self value ] reset ]