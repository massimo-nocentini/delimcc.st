tests - review 1
testThousandShotsOfNonLocalReturns

	self assert: (self isolated: [
			 | k |
			 k := [ self returnOfK + 1 ] reset.
			 (1 to: 1000) inject: 0 into: [ :sum :i | sum + (k value: i) ] ]) equals: 501500.
	self assert: (self isolated: [
			 | k |
			 k := [ #( 1 2 3 ) detect: [ :x | [ :kk | kk ] shift ] ifNone: [ 0 ] ] reset.
			 (1 to: 1000) inject: 0 into: [ :sum :i |
				 | v |
				 v := k value: i odd.
				 sum + (v isNumber ifTrue: [ v ] ifFalse: [ 1 ]) ] ]) equals: 1000