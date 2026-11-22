testing - exceptions
testShiftIgnoresGenericHandlers
	"The handlers between a shift and its reset become part of k: they are not asked where the reset is."

	self
		assert: [ [ 1 + [ :k | k value: 1 ] shift ] on: Exception do: [ :e | e return: #caught ] ] reset
		equals: 2.
	self
		assert: [ [ 1 + [ :k | k value: 1 ] shift ] on: Notification do: [ :e | e resume: 5 ] ] reset
		equals: 2