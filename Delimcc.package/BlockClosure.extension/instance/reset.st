*Delimcc
reset
	"Mark the call stack. The handler says 'Exception, this is where the nearest reset is."

	| ctx |
	ctx := thisContext.

	^ self
		  on: DelimitedControlException
		  do: [ :e | e resume: ctx ]