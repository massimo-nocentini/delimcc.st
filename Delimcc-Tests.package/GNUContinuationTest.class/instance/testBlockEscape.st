utilities
testBlockEscape

	| x tmp tmp2 |
	tmp := 0.
	x := [
	     tmp := tmp + 1.
	     tmp2 value ].
	self callcc: [ :cc |
		tmp2 := cc.
		x value ].
	tmp2 := [  ].
	x value.
	self assert: tmp equals: 2