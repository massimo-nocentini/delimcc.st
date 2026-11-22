tests - review 2
testHandlerSliceAfterItsReset

	self
		assert: (self isolated: [
				 | k |
				 k := [ ([ 1 / 0 ] on: ZeroDivide do: [ :e | [ :kk | kk ] shift ]) * 10 ] reset.
				 {
					 (k value: 1).
					 (k value: 2).
					 (k value: 3) } ])
		equals: #( 10 20 30 ).
	self
		assert: (self isolated: [
				 {
					 [ ([ [ 1 / 0 ] ensure: [ log add: #ensure ] ] on: ZeroDivide do: [ :e | [ :kk | (kk value: 1) + (kk value: 2) ] shift ]) * 10 ] reset.
					 log asArray } ])
		equals: #( 30 #( #ensure #ensure ) )