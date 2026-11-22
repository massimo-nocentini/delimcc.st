tests - limits
testTempRollbackDependsOnTempVectors
	"Unchanged limit: re-entry restores the temporaries that live in the frame, not those that the compiler moves to a temp vector because a block writes them, nor instance variables."

	self assert: self rollbackFrameTemp equals: 1.
	self assert: self rollbackTempVectorTemp equals: 3.
	self assert: self rollbackInstanceVariable equals: 3