tests - limits
testReenteredHandlerReturnsFromTheCurrentHandler
	"Unchanged limit: the Exception is not part of the snapshot. The inner handler passed it to the outer one, so on re-entry its return: leaves from the outer on:do:, which skips the + 1000."

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
				      ifFalse: [ e return: v ] ]) + 1000 ]
		     on: Error
		     do: [ :e | e return: 7 ].
	log add: r.
	log size < 2 ifTrue: [ k value: 5 ].
	self assert: log asArray equals: #( 7 5 )