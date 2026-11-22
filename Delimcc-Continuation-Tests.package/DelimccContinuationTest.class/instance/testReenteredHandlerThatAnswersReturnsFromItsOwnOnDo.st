tests - limits
testReenteredHandlerThatAnswersReturnsFromItsOwnOnDo
	"The contrast of #testReenteredHandlerReturnsFromTheCurrentHandler: a re-entered handler that answers its value without touching the Exception returns from its own on:do:."

	| r |
	log := OrderedCollection new.
	r := [
	     ([ Error signal: #boom ]
		      on: Error
		      do: [ :e |
			      | v |
			      v := Continuation currentDo: [ :c |
				           k := c.
				           0 ].
			      v = 0
				      ifTrue: [ e pass ]
				      ifFalse: [ v ] ]) + 1000 ]
		     on: Error
		     do: [ :e | e return: 7 ].
	log add: r.
	log size < 2 ifTrue: [ k value: 5 ].
	self assert: log asArray equals: #( 7 1005 )