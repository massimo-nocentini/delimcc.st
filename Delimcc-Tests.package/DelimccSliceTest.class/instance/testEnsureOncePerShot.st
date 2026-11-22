tests - ensure
testEnsureOncePerShot

	self assert: { [ [ [ :k | (k value: 2) + (k value: 3) ] shift ] ensure: [ log add: #ensure ] ] reset. log asArray } equals: #( 5 #( #ensure #ensure ) ).
	log removeAll.
	self assert: { [ [ [ :k | k value: 2 ] shift ] ensure: [ log add: #ensure ] ] reset. log asArray } equals: #( 2 #( #ensure ) ).
	log removeAll.
	self assert: (self isolated: [ { [ self returnThroughEnsure + 1 ] reset. log asArray } ]) equals: #( 32 #( #ensure #ensure ) )