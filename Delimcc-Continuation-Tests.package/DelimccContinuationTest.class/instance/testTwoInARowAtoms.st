tests - fixes
testTwoInARowAtoms
	"A stock TwoInARowStar>>#tree: answered false unless the first atom was a Symbol, and nil ended the walk, so nil could not be an atom."

	self assert: (TwoInARowStar new tree: 1 ~~> (1 ~~> nil)).
	self deny: (TwoInARowStar new tree: 1 ~~> (2 ~~> nil)).
	self assert: (TwoInARowStar new tree: 1 ~~> (#a ~~> (#a ~~> nil))).
	self assert: (TwoInARowStar new tree: (1 ~~> nil) ~~> (1 ~~> nil)).
	self assert: (TwoInARowStar new tree: 'x' ~~> ('x' ~~> nil)).
	self assert: (TwoInARowStar new tree: nil ~~> (nil ~~> nil)).
	self deny: (TwoInARowStar new tree: nil ~~> (1 ~~> nil)).
	self deny: (TwoInARowStar new tree: Link new).
	self deny: (TwoInARowStar new tree: nil)