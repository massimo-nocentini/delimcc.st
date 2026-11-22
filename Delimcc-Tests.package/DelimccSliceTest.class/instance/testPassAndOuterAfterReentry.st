tests - review 2
testPassAndOuterAfterReentry

	self
		assert: (self isolated: [
				 [
				 [
				 [ 1 / 0 ]
					 on: ZeroDivide
					 do: [ :e |
						 [ :k | (k value: 1) + (k value: 2) ] shift.
						 e pass ] ]
					 on: ZeroDivide
					 do: [ :e | -1 ] ] reset ])
		equals: -2.
	self
		assert: (self isolated: [
				 [
				 [
				 [ (Warning signal: 'w') + 10 ]
					 on: Warning
					 do: [ :e |
						 | v |
						 v := [ :k | (k value: 1) + (k value: 2) ] shift.
						 e resume: e outer + v - 10 ] ]
					 on: Warning
					 do: [ :e | e resume: 5 ] ] reset ])
		equals: 13