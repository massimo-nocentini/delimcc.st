*Delimcc
resetContext: context
	"Mark the call stack. The handler says 'Exception, this is where the nearest reset is."

	^ self
		  on: DelimitedControlException
		  do: [ :e | e resume: context ]