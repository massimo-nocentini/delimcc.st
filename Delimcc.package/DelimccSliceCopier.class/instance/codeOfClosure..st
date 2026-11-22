codes
codeOfClosure: aClosure
	"R3: copy aClosure when its outer context (instance variable 1), its receiver (4) or one of its copied values (negative fields) has a copy."

	| outer receiver values code |
	(ablated == nil or: [ self applies: #closures ]) ifFalse: [ ^ 0 ].
	originals == nil ifFalse: [ (self codeOf: aClosure) ifNotNil: [ :known | ^ known ] ].
	outer := aClosure outerContext.
	outer := outer == nil
		         ifTrue: [ 0 ]
		         ifFalse: [ self codeOfContext: outer ].
	receiver := (ablated == nil or: [ self applies: #receivers ])
		            ifTrue: [ aClosure receiver sliceCodeDelimcc: self ]
		            ifFalse: [ 0 ].
	1 to: aClosure basicSize do: [ :i |
		| value |
		value := (aClosure basicAt: i) sliceCodeDelimcc: self.
		value = 0 ifFalse: [ (values ifNil: [ values := Array new: aClosure basicSize withAll: 0 ]) at: i put: value ] ].
	(outer = 0 and: [ receiver = 0 and: [ values == nil ] ]) ifTrue: [ ^ 0 ].
	code := self register: aClosure.
	outer = 0 ifFalse: [ self patch: 1 of: code to: outer ].
	receiver = 0 ifFalse: [ self patch: 4 of: code to: receiver ].
	values ifNotNil: [
		1 to: values size do: [ :i | (values at: i) = 0 ifFalse: [ self patch: 0 - i of: code to: (values at: i) ] ] ].
	^ code