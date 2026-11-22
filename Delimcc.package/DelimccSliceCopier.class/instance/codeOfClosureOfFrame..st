codes
codeOfClosureOfFrame: aClosureOrNil
	"R2: the code of the copy of aClosureOrNil, the closure that a context runs, through which a ^ in it finds its home."

	^ aClosureOrNil sliceCodeDelimcc: self