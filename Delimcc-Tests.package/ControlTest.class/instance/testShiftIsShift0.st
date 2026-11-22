testing
testShiftIsShift0
	"From Chung-chieh Shan's 'Shift to control': (reset (cons 'a (reset (shift f (shift g '()))))).
	The body of a shift runs without the reset it cut to, so the inner shift captures 'a' , _ and discards it: shift0 answers '', shift would answer 'a'."

	self assert: [ 'a' , [[:f | [:g| g value: 'b'] shift ] shift] reset ] reset equals: 'ab'.
	self assert: [ 'a' , [[:f | [:g| ''] shift ] shift] reset ] reset equals: ''