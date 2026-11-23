codes
codeOfClosure: aClosure
	"R3: copy aClosure when its outer context (instance variable 1), its receiver (4) or one of its copied values (negative fields) has a copy. A shared closure that holds other closures is remembered, so that it is scanned once, with them, however many fields hold it."

	| scans outer receiver values code |
	originals ifNotNil: [ (self codeOf: aClosure) ifNotNil: [ :known | ^ known ] ].
	outer := aClosure outerContext
		         ifNil: [ 0 ]
		         ifNotNil: [ :context | self codeOfContext: context ].
	(outer = 0 and: [ self isShared: aClosure ]) ifTrue: [ ^ 0 ].
	scans := closureScans := closureScans + 1.
	receiver := self codeOfReceiver: aClosure receiver.
	1 to: aClosure basicSize do: [ :i |
		| value |
		value := (aClosure basicAt: i) sliceCodeDelimcc: self.
		value = 0 ifFalse: [ (values ifNil: [ values := Array new: aClosure basicSize withAll: 0 ]) at: i put: value ] ].
	(outer = 0 and: [ receiver = 0 and: [ values isNil ] ]) ifTrue: [
		^ closureScans = scans
			  ifTrue: [ 0 ]
			  ifFalse: [ self shared: aClosure ] ].
	code := self register: aClosure.
	outer = 0 ifFalse: [ self patch: 1 of: code to: outer ].
	receiver = 0 ifFalse: [ self patch: 4 of: code to: receiver ].
	values ifNotNil: [
		1 to: values size do: [ :i | (values at: i) = 0 ifFalse: [ self patch: 0 - i of: code to: (values at: i) ] ] ].
	^ code