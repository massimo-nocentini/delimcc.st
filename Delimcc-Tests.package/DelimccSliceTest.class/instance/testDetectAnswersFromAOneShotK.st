tests - review 1
testDetectAnswersFromAOneShotK
	"p.st A1 of the review: the ^ of detect: in the block of the first invocation, which runs the contexts of the slice."

	self assert: (self isolated: [ [ #( 1 2 3 ) detect: [ :x | [ :kk | kk value: x = 2 ] shift ] ] reset ]) equals: 2.
	self assert: (self isolated: [ [ #( 1 2 3 ) anySatisfy: [ :x | [ :kk | kk value: x = 2 ] shift ] ] reset ])