tests - temps
testTempsArePerShot
	"A temporary of the slice is copied with it whatever the compiler did with it: each invocation starts from the state of the first one."

	self assert: self tempInTheContext equals: 2.
	self assert: self tempReadByABlock equals: 2