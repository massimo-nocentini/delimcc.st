tests - review 2
testErrorOfASecondShotOutsideTheSlice

	self
		assert: (self isolated: [
				 [
				 [
				 ([ 1 / 0 ] on: ZeroDivide do: [ :e |
					  | v |
					  v := [ :k | (k value: 1) + (k value: 2) ] shift.
					  v = 2 ifTrue: [ Error signal: 'boom' ].
					  v ]) * 10 ] reset ]
					 on: Error
					 do: [ :e | #outer ] ])
		equals: #outer