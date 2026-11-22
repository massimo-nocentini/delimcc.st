tests - limits
testReentryRerunsTheCapturedEnsureBlocks
	"Unchanged limit: re-entering an ensure: frame that has already completed rolls back its complete flag, so its block runs once per exit."

	count := 0.
	shots := 0.
	[
	tmp := Continuation current.
	(tmp isKindOf: Continuation) ifTrue: [ k := tmp ] ] ensure: [
		count := count + 1 ].
	shots := shots + 1.
	shots < 3 ifTrue: [ k value: shots ].
	self assert: shots equals: 3.
	self assert: count equals: 3