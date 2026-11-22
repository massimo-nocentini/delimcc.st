private
codeOf: anObject
	"Answer the code of the copy of anObject that I have made, or nil."

	codes ifNotNil: [ ^ codes at: anObject ifAbsent: [ nil ] ].
	1 to: originals size do: [ :i | (originals at: i) == anObject ifTrue: [ ^ 0 - i ] ].
	^ nil