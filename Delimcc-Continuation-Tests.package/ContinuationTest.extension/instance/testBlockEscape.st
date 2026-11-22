*Delimcc-Continuation-Tests-tests
testBlockEscape

	| x afterEscape |
	tmp := 0.
	afterEscape := OrderedCollection new.
	x := [
	     tmp := tmp + 1.
	     tmp2 value.
	     afterEscape add: tmp ].
	self callcc: [ :cc |
		tmp2 := cc.
		x value ].
	tmp2 := [  ].
	x value.
	self assert: tmp equals: 2.
	"the escape through cc skipped the rest of the first evaluation of x"
	self assert: afterEscape asArray equals: #( 2 )