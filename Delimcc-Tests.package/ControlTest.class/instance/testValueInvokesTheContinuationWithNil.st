testing
testValueInvokesTheContinuationWithNil
	| cc log |
	log := OrderedCollection new.
	[ log add: [ :k | cc := k. #first ] shift ] reset.
	self assert: cc value isNil.
	self assert: #(nil) equals: log asArray