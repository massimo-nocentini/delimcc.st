copying
fixObject: aCode
	"Record the patches of the copied object of aCode, a temp vector or an exception, now that every context is fixed."

	| object code |
	object := objects at: aCode negated.
	1 to: object class instSize do: [ :i |
		code := (object instVarAt: i) sliceCodeDelimcc: self.
		code = 0 ifFalse: [ self patch: i of: aCode to: code ] ].
	1 to: object basicSize do: [ :i |
		code := (object basicAt: i) sliceCodeDelimcc: self.
		code = 0 ifFalse: [ self patch: i negated of: aCode to: code ] ]