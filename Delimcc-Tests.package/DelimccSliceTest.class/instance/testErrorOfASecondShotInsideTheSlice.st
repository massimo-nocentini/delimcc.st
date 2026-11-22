tests - review 2
testErrorOfASecondShotInsideTheSlice

	self
		assert: (self isolated: [
				 [
				 [
				 ([ 1 / 0 ] on: ZeroDivide do: [ :e |
					  | v |
					  v := [ :k | (k value: 1) + (k value: 2) ] shift.
					  v = 2 ifTrue: [ Error signal: 'boom' ].
					  v ]) * 10 ]
					 on: Error
					 do: [ :e | 100 ] ] reset ])
		equals: 110